import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22272B),

      body: Stack(
        children: [

          Column(
            children: [
              SizedBox(height:16),
              Row(
                children: [
                  SizedBox(width:16),
                  IconButton(
                    icon: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height:32),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity: 0.7, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/settings_about_img.png', // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ),
              SizedBox(height:32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Show task input form
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => SetGoalPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Let\'s Start'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

