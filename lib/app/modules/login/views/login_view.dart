import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final bool isLoading = true;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: secondaryColor,
              // pinned: true,
              expandedHeight: bodyHeight * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'GassKen',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Lottie.asset('assets/lottie/truck.json',
                        width: 100, height: 100),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Masukkan akunmu terlebih dahulu ya su...',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: controller.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            labelText: 'Email',
                            hintText: 'Masukkan Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Obx(
                          () => TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.obscureText.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Jangan kosong ah';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscureText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  controller.toglePasswordVisibility();
                                },
                              ),
                              labelText: 'Password',
                              hintText: 'Masukkan Password',
                              prefixIcon: Icon(Icons.lock_rounded, color: primaryColor,),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                          child: Container(
                            width: mediaQueryWidth,
                            child: Text(
                              "Lupa Password?",
                              style:
                                  TextStyle(fontSize: 14, color: primaryColor),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Obx(() {
                          return controller.isLoadingLogin.value
                              ? Center(
                                  child: Lottie.asset(
                                    "assets/lottie/load.json",
                                    height: 100,
                                    width: 100,
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    minimumSize: const Size.fromHeight(40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.login();
                                    }
                                  },
                                  child: Text(
                                    'Masuk Sekarang',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                        }),
                        SizedBox(height: 4.0),
                        Center(
                          child: Text(
                            'atau',
                            style: TextStyle(fontSize: 14, color: primaryColor),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bgColor,
                            minimumSize: const Size.fromHeight(40),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.0, color: primaryColor),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () => Get.toNamed(Routes.SIGNUP),
                          child: const Text(
                            'Daftar di sini',
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
