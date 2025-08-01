import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfavsdb/src/models/response_model.dart';
import 'package:myfavsdb/src/pages/auth/controller/auth_controller.dart';
import 'package:myfavsdb/src/services/utils_services.dart';

import '../../../pages_routes/app_pages.dart';
import '../../base/base_screen.dart';
import '../components/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final utilsServices = UtilsServices();

  //Controlador campo de texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Nome do App
                      const Text.rich(TextSpan(
                          style: TextStyle(
                            fontSize: 40,
                          ),
                          children: [
                            TextSpan(
                              text: 'Tag',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: 'Me',
                                style: TextStyle(
                                  color: Colors.purple,
                                ))
                          ])),

                      //Categorias
                      SizedBox(
                        height: 30,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                          child: AnimatedTextKit(
                            pause: Duration.zero,
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText('Filmes'),
                              FadeAnimatedText('Séries'),
                              FadeAnimatedText('Álbuns'),
                              FadeAnimatedText('Livros'),
                              FadeAnimatedText('Jogos'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),

              //Formulário
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 40),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      )),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Email
                        CustomTextField(
                          controller: emailController,
                          icon: Icons.email,
                          label: 'Email',
                          validator: (email) {
                            if (email == null || email.isEmpty)
                              return 'Digite seu email!';

                            if (!email.isEmail)
                              return 'Digite um email válido!';

                            return null;
                          },
                        ),

                        //Senha
                        CustomTextField(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: 'Senha',
                          isSecret: true,
                          validator: (password) {
                            if (password == null || password.isEmpty)
                              return 'Digite sua senha!';

                            if (password.length < 6)
                              return 'A senha deve ter no mínimo 6 caracteres!';

                            return null;
                          },
                        ),

                        //Entrar
                        SizedBox(
                            height: 45,
                            child: GetX<AuthController>(
                              builder: (authController) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      )),
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                    FocusScope.of(context).unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      authController.signIn(email: emailController.text,
                                          password: passwordController.text).then((response) {
                                        if (response.statusCode == 200) {
                                          utilsServices.showToast(
                                            message: response.returnMsg,);
                                          Get.offNamed(PagesRoutes.baseRoute);
                                        } else {
                                          utilsServices.showToast(
                                            message: response.returnMsg,
                                            isError: true,);
                                        }
                                      });
                                    }
                                  },
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      :
                                  const Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                            )
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
