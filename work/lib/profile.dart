import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                 /// Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.deepPurple, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              

                SizedBox(height: 50),
                 const Text(
                  "Create Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900 , color: Colors.deepPurple),
                ),
                Text("Create Your Profile to Get Started!", style: TextStyle(fontSize: 20 ,color: Colors.grey),),
                SizedBox(height: 15),

                // Image picker
                GestureDetector(
                  // onTap: imageadd,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 50,
                    
                     child: Icon(Icons.camera_alt,size: 40, color: Colors.deepPurple, ),
                     
                    // backgroundImage: imgbytes != null ? MemoryImage(imgbytes!) : null,
                    // child: imgbytes == null ? Icon(Icons.person ,size: 70, )  : null,
                  ),
                ),

               
                SizedBox(height: 20),
               
                SizedBox(height: 20),
                // Username input
                SizedBox(
                          width: 250,
                          child: TextField(
                            // controller: _city,
                            decoration: InputDecoration(
                              hintText: "Username",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.deepPurple,
                              ), // Email icon
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   borderSide: BorderSide.none,
                              // ),
                              // fillColor: Colors.orangeAccent[50],
                              // filled: true,
                            ),
                          ),
                        ),
                SizedBox(height: 20),

                // Email input
                SizedBox(
                          width: 250,
                          child: TextField(
                            // controller: _city,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.deepPurple,
                              ), // Email icon
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   borderSide: BorderSide.none,
                              // ),
                              // fillColor: Colors.orangeAccent[50],
                              // filled: true,
                            ),
                          ),
                        ),
                SizedBox(height: 20),

                // Phone input
               SizedBox(
                          width: 250,
                          child: TextField(
                            // controller: _city,
                            decoration: InputDecoration(
                              hintText: "Phone",
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.deepPurple,
                              ), // Email icon
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   borderSide: BorderSide.none,
                              // ),
                              // fillColor: Colors.orangeAccent[50],
                              // filled: true,
                            ),
                          ),
                        ),
                SizedBox(height: 20),

                
                  SizedBox(
                          width: 250,
                          child: TextField(
                            // controller: _city,
                            decoration: InputDecoration(
                              hintText: "City",
                              prefixIcon: Icon(
                                Icons.location_city_sharp,
                                color: Colors.deepPurple,
                              ), // Email icon
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   borderSide: BorderSide.none,
                              // ),
                              // fillColor: Colors.orangeAccent[50],
                              // filled: true,
                            ),
                          ),
                        ),
                      SizedBox(height: 20),

                // Submit button
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                    
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 50),
                              elevation: 10,
                              shadowColor: Colors.deepPurple.withOpacity(0.9),
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                                                       
                     
                    ),
                    child: Text("Save"),
                  ),
                ),
              
              ],
            ),
          ),
        ),
      ),
    );

  }
}