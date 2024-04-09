import 'package:clean_arch_tdd_bloc/core/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/authentication/presentation/cubit/authentication_cubit.dart';
import 'src/authentication/presentation/views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // whenever async and Future is used we instantiate this.

  await init(); // instantiating the dependencies

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (context) => serviceLocator<AuthenticationCubit>(),
      // already defined dependencies using getIt, else we would have to provide all the dependencies here.

      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
