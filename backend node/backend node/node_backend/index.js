const express = require('express');
const bodyParser = require('body-parser');
const UserData = require('./data_classes/user_data');
const { MongoClient, ObjectId } = require('mongodb');
const { createClient } = require('@supabase/supabase-js');
const cron = require('node-cron');

const {
    createRecord,
    readRecord,
    updateRecord,
    deleteRecord,
    crud,
    login_post_method,
    signup_post_method,
    sendOTP,
    verifyOTP,
    reset_pass_function
} = require('./auth_operations');
// // index.js
const { create, read, update, del, executeQuery } = require('./db_operations');
const app = express();
const port = 3500;


// TODO: Schedule the notification scheduler execution time
const schedulingTime = "20:30";

// Define your quotes array
const quotesList = [
    ["The only way to do great work is to love what you do.", "Steve Jobs"],
    ["Success is not final, failure is not fatal: It is the courage to continue that counts.", "Winston Churchill"],
    ["Believe you can and you're halfway there.", "Theodore Roosevelt"],
    ["The future belongs to those who believe in the beauty of their dreams.", "Eleanor Roosevelt"],
    ["It does not matter how slowly you go as long as you do not stop.", "Confucius"],
    ["You are never too old to set another goal or to dream a new dream.", "C.S. Lewis"],
    ["Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.", "Albert Schweitzer"],
    ["The only limit to our realization of tomorrow will be our doubts of today.", "Franklin D. Roosevelt"],
    ["The best way to predict the future is to create it.", "Abraham Lincoln"],
    ["The only source of knowledge is experience.", "Albert Einstein"],
    // Add more quotes as needed
  ];


app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const supabaseUrl = 'https://jqmrqedgufyvwewpqcfg.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxbXJxZWRndWZ5dndld3BxY2ZnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTMyODY5NDgsImV4cCI6MjAyODg2Mjk0OH0.z3aOq_fMqXC1GJUvSdvmC-hpZkmbSW26U-qdWU9hJq8';
const supabase = createClient(supabaseUrl, supabaseKey);

const admin = require('firebase-admin');
const serviceAccount = require('./firebase_service.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

// Store scheduled notifications and their timers
const scheduledNotifications = {};


function scheduleNotification(time, notificationData, deviceToken) {
  // Get the current time
  const currentTime = new Date();
  const currentHours = currentTime.getHours();// 
  const currentMinutes = currentTime.getMinutes();

  // Parse the provided time string (e.g., "14:30")
  const [targetHour, targetMinute] = time.split(':').map(Number);

  // Calculate the time difference until the target time
  let timeDifference = (targetHour - currentHours) * 60 + (targetMinute - currentMinutes);

  // If the target time has already passed for today, add 24 hours to the time difference
  if (timeDifference < 0) {
    timeDifference += 24 * 60;
  }

  // Convert the time difference to milliseconds
  const delayMilliseconds = timeDifference * 60 * 1000;

  // Set a timer to execute the function after the delay
  const timer = setTimeout(() => {
    // Construct the message with notification data
    const message = {
      notification: {
        title: notificationData.title,
        body: notificationData.body,
        imageUrl: notificationData.imageUrl,
      },
      token: deviceToken,
    };

    // Send the notification
    admin.messaging().send(message)
      .then((response) => {
        console.log('Successfully sent message:', response);
      })
      .catch((error) => {
        console.log('Error sending message:', error);
      });

    // Remove the timer from the scheduled notifications
    delete scheduledNotifications[deviceToken];
  }, delayMilliseconds);

  // Store the timer for cancellation later
  scheduledNotifications[deviceToken] = timer;
}






// // Example usage:
// const notificationTime1 = '16:18'; // Time in HH:mm format
// const notificationData1 = {
//   title: 'Notification Title',
//   body: 'Notification Body',
//   icon: 'notification_icon',
//   imageUrl: 'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
// };


// // Schedule a notification
// scheduleNotification(notificationTime1, notificationData1, registrationToken);


async function connect() {
    const uri = "mongodb+srv://goal_setting:goal_setting_123@cluster0.wxus2z3.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
    const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
    const dbName = 'goal_setting';
    try {
        await client.connect();
        console.log("Connected to MongoDB successfully");
        return client.db(dbName);
    } catch (error) {
        console.error("Error connecting to MongoDB:", error);
        throw error;
    }
}

async function getAllUserPassPairs() {
    try {
        // Select all UUIDs from the table
        const { data: allUUIDs, error } = await supabase
            .from('goalkeepingapp_users_id')
            .select('username, password');


        if (error) {
            console.error('Error fetching UUIDs:', error.message);
            throw new Error('An error occurred while fetching UUIDs.');
        }

        // Extract UUIDs into an array
        const uuids = allUUIDs;

        return uuids;
    } catch (error) {
        console.error('Exception occurred:', error);
        throw new Error('An error occurred while processing the request.');
    }
}




// Function to retrieve all globalData objects
async function getAllGlobalData() {
    try {
        // Connect to MongoDB
        // Connect to MongoDB
        const db = await connect();
        const collection = db.collection('goal_setting');

        // Find all documents in the collection
        const cursor = collection.find({});
        const globalDataArray = [];

        // Iterate over the cursor to extract globalData objects
        await cursor.forEach(doc => {
            globalDataArray.push(doc.globalData);
        });

        return globalDataArray;
    } catch (error) {
        console.error('Error fetching global data:', error);
        throw new Error('An error occurred while fetching global data.');
    }
}

async function filterGlobalData(userPassPairs, allGlobalData) {
    const filteredGlobalData = [];

    userPassPairs.forEach(pair => {
        const { username, password } = pair;


        const userDataMatch = allGlobalData.find(data => {
            return data.userData.username === username &&
                data.userData.password === password &&
                data.userData.notificationsOn === true &&
                (data.goals7Days.length + data.goals21Days.length + data.customGoals.length) > 0;
        });

        if (userDataMatch) {
            filteredGlobalData.push(userDataMatch);
        }
    });

    return filteredGlobalData;
}


// Function to parse notification time from string to TimeOfDay format
function parseNotificationTime(notificationTimeStr) {
    const [hour, minute] = notificationTimeStr.split(':').map(Number);
    return { hour, minute };
}

// Function to check if a date is in the future
function isFutureDate(dateStr) {
    const targetDate = new Date(dateStr);
    const currentDate = new Date();
    return targetDate > currentDate;
}

// Function to retrieve all user-password pairs and all globalData objects
async function getAllUserData() {
    try {
        const userPassPairs = await getAllUserPassPairs();
        const allGlobalData = await getAllGlobalData();

        // console.log('All user-password pairs:', userPassPairs);
        // console.log('All globalData objects:', globalData);
        // return { userPassPairs, globalData };

        const filteredData = await filterGlobalData(userPassPairs, allGlobalData);
        // console.log('Filtered global data:', filteredData);

        // Iterate through each filtered global data object
        filteredData.forEach(async (userData) => {
            // Extract all goals from the userData object
            const allGoals = [
                ...userData.goals7Days,
                ...userData.goals21Days,
                ...userData.customGoals // Flatten the customGoals array before extracting goals
            ];

            // console.log('All Goals:', allGoals);

            // Convert notification time to TimeOfDay format
            const notificationTime = parseNotificationTime(userData.userData.notificationTime);
            // console.log('notificationTime:', notificationTime);
            console.log((notificationTime.hour+":"+notificationTime.minute).toString());


        const notificationTimeString = (notificationTime.hour+":"+notificationTime.minute).toString();

            const serviceToken = userData.userData.FirebaseServiceToken;

            // Iterate through each goal
            allGoals.forEach(goal => {
                // Check if the target date is in the future
                if (isFutureDate(goal.targetDate)) {

                    let notification_title = goal.name;
                    console.log('title: ', notification_title);

                    let imageUrl = goal.ImageURL;
                    // console.log('ImageURL:: ', imageUrl);

                    let bodyOfThe_Notification = "";
                    // Iterate through each goal
                    goal.tasks.forEach(task => {
                        bodyOfThe_Notification += task.name;
                        bodyOfThe_Notification += "\n";
                    });

                    // console.log('bodyOfThe_Notification: ', bodyOfThe_Notification);




                    // Notification body
                    const Scheduled_notificationTime = notificationTime; // Time in HH:mm format
                    const notificationData = {
                        title: notification_title,
                        body: bodyOfThe_Notification,
                        imageUrl: imageUrl
                    };


                    scheduleNotification(notificationTimeString , notificationData, serviceToken);

                }
            });
        });
    } catch (error) {
        console.error('Error fetching all user data:', error.message);
        throw new Error('An error occurred while fetching all user data.');
    }
}


// TODO: 
// getAllUserData();

// Parse the hour and minute from the scheduling time
const [hour, minute] = schedulingTime.split(':').map(Number);

// Schedule the task to run at the specified time every day
cron.schedule(`${minute} ${hour} * * *`, () => {
    // Run your function here
    console.log('executed the scheduler now at ' + hour + ":" + minute);
    getAllUserData();
}, {
    timezone: "Asia/Kolkata"
});



// Login route
app.post('/login', async (req, res) => {
    let { username, password } = req.body;

    try {
        const result = await login_post_method(username, password);
        res.json(result);
    } catch (error) {
        console.error('Error occurred during login:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Signup route
app.post('/signup', async (req, res) => {
    const { name, age, username, email, mobile, password } = req.body;

    try {
        const result = await signup_post_method(name, age, username, email, mobile, password);
        res.json(result);
    } catch (error) {
        console.error('Error occurred during signup:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Send OTP route
app.post('/send_otp', async (req, res) => {
    const { method, contact, isNumericOTP, otpDigitCount, otpCountdownTime } = req.body;

    try {
        const result = await sendOTP(contact, method, isNumericOTP, otpDigitCount);
        res.json(result);
    } catch (error) {
        console.error('Error occurred while sending OTP:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Verify OTP route
app.post('/verify_otp', async (req, res) => {
    const { method, contact, otp } = req.body;

    try {
        const result = await verifyOTP(method, contact, otp);
        res.json(result);
    } catch (error) {
        console.error('Error occurred while verifying OTP:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Reset password route
app.post('/reset_password', async (req, res) => {
    const { method, contact, password } = req.body;

    try {
        reset_pass_function(method, contact, password, res);
    } catch (error) {
        console.error('Error occurred while resetting password:', error.message);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});
// FIXME: above is completed


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function to create or retrieve user UUID based on username and password


const ID_table = "goalkeepingapp_users_id"

function generateUniqueID() {
    // Generate a random number and convert it to base 36
    const randomNumber = Math.random().toString(36).substring(2);
    // Generate a timestamp and convert it to base 36
    const timestamp = (new Date()).getTime().toString(36);
    // Concatenate the random number and timestamp to create a unique ID
    const uniqueID = randomNumber + timestamp;
    return uniqueID;
}


async function getUserUUID(username, password, FirebaseServiceToken) {
    try {
        // Check if the user with the provided username and password exists
        const { data: existingUsers, error } = await supabase
            .from(ID_table)
            .select('uuid')
            .eq('username', username)
            .eq('password', password);

        if (error) {
            console.error('Error checking for existing user:', error.message);
            return { error: 'Internal server error' };
        }

        if (existingUsers && existingUsers.length > 0) {
            // User already exists, return the UUID
            return { uuid: existingUsers[0].uuid };
        } else {
            // User doesn't exist, generate a unique ID and save it
            const newUuid = generateUniqueID();

            // Insert the new user with the generated UUID
            const { data: newUser, error: insertError } = await supabase
                .from(ID_table)
                .insert([{ username, password, uuid: newUuid, firebaseservicetoken: FirebaseServiceToken }]);

            if (insertError) {
                console.error('Error inserting new user:', insertError.message);
                return { error: 'Internal server error' };
            }

            // Return the generated UUID for the new user
            return { uuid: newUser[0].uuid };
        }
    } catch (e) {
        console.error('Exception occurred:', e);
        return { error: 'Internal server error' };
    }
}

// TODO: save data
async function saveGlobalData(globalData, uniqueId) {
    try {
        // Check if the document with the unique ID exists in MongoDB
        const existingData = await read('goal_setting', { uuid: uniqueId });
        if (existingData.length > 0) {
            // Document exists, update the document with the provided GlobalData
            await update('goal_setting', { uuid: uniqueId }, { globalData });
        } else {
            // Document doesn't exist, create a new document with the provided GlobalData and unique ID
            await create('goal_setting', { uuid: uniqueId, globalData });
        }
    } catch (error) {
        console.error('Error while saving GlobalData:', error);
        throw error;
    }
}
// TODO: Get data
async function getGlobalData(uniqueId) {
    try {
        // Read the document with the provided unique ID from MongoDB
        const data = await read('goal_setting', { uuid: uniqueId });
        if (data.length > 0) {
            // Document found, return the GlobalData
            return data[0].globalData;
        } else {
            // Document not found, return null
            console.log('No data found for the provided unique ID:', uniqueId);
            return null;
        }
    } catch (error) {
        console.error('Error while fetching GlobalData:', error);
        throw error;
    }
}


app.post('/update_global_data', async (req, res) => {
    try {
        // Extract username and password from userData
        const { username, password } = req.body.userData;
        const globalData = req.body;

        // Print username and password on CLI
        console.log('Username:', username);
        console.log('Password:', password);

        const uniqueId = await getUserUUID(username, password);

        await saveGlobalData(globalData, uniqueId);

        console.log("the data is : ", globalData)

        // Send response
        res.json({ success: true, uuid, message: 'Data received successfully.' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'An error occurred while processing the request.' });
    }
});


// Endpoint to send global data to frontend based on username and password
app.post('/get_global_data', async (req, res) => {
    try {
        // Extract username and password from request body
        const { username, password, FirebaseServiceToken } = req.body;

        console.log("\n\nFirebaseServiceToken is : ", FirebaseServiceToken, "\n\n");

        const uniqueId = await getUserUUID(username, password, FirebaseServiceToken);

        const globalDataFromDatabase = await getGlobalData(uniqueId);


        if (globalDataFromDatabase) {
            // Send global data as JSON response
            res.json({ globalDataFromDatabase });
        } else {
            res.status(404).json({ success: false, message: 'Global data not found for the provided username and password.' });
        }
    } catch (error) {
        res.status(500).json({ success: false, message: 'An error occurred while fetching global data.' });
    }
});



  
  // Route to serve quotes
  app.get('/quotes', (req, res) => {
    res.json(quotesList);
  });


// Start the server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});