import 'package:flutter/material.dart';
import 'package:voumarketinggame/pages/signup_infor_page.dart';
import 'package:voumarketinggame/theme/theme.dart';


class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
   
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  bool _isOtpComplete = false;

void _checkOtpComplete() {
  setState(() {
    
    _isOtpComplete = _controllers.every((controller) => controller.text.isNotEmpty);
  });
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    
                    children: [
                     
                      IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ]
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Verification code",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We have sent the code verification to\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Text(
                    "+ *******921",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        height: 64,
                        width: 64,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                            fillColor: Colors.white10,
                            filled: true,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < 3) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index + 1]);
                              } else {
                                FocusScope.of(context).unfocus();
                                // Add logic when all digits are entered
                              }
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index - 1]);
                            }
                            _checkOtpComplete();
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Resend code after 1:36",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  const SizedBox(height: 100),
                  
                  Row(
                    
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.white, 
                            side:  BorderSide(color: lightColorScheme.onPrimary), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Resend",
                            style: TextStyle(
                              fontSize: 18,
                              color: lightColorScheme.onPrimary,
                            ),
                            ),
      
                        ),
                      ),
                    ),
      
                    const SizedBox(width: 50),
                    
                    Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isOtpComplete
                            ? () {
                                // ignore: unused_local_variable
                                String otpCode = _controllers.map((c) => c.text).join();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (e) => const UserInfoScreen(),
                                  ),
                                );
                              }
                            : null, 
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: _isOtpComplete
                              ? lightColorScheme.primary 
                              : Colors.white, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 18,
                            color: _isOtpComplete
                                ? Colors.white 
                                : Colors.white24, 
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  ],
                ),
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}
