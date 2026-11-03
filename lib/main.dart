import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MasJekApp());
}

class MasJekApp extends StatelessWidget {
  const MasJekApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MasJek',
      theme: ThemeData(primarySwatch: Colors.green),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  String error = '';
  bool loading = false;

  Future<void> login() async {
    setState(() { loading = true; error = ''; });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passC.text.trim(),
      );
    } catch (e) {
      setState(() { error = 'Login gagal, coba Daftar dulu.'; });
    }
    setState(() { loading = false; });
  }

  Future<void> daftar() async {
    setState(() { loading = true; error = ''; });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passC.text.trim(),
      );
    } catch (e) {
      setState(() { error = 'Daftar gagal: $e'; });
    }
    setState(() { loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.motorcycle, size: 80, color: Colors.green),
            const Text('MasJek', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text('Login biar bisa order kayak Gojek'),
            const SizedBox(height: 24),
            TextField(controller: emailC, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: passC, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            if (error.isNotEmpty) Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: loading ? null : login, child: Text(loading ? 'Tunggu...' : 'Lanjutkan / Masuk')),
            ),
            TextButton(onPressed: loading ? null : daftar, child: const Text('Belum punya akun? Klik Daftar')),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MasJek'),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () => FirebaseAuth.instance.signOut())],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Halo, ${FirebaseAuth.instance.currentUser?.email}', style: const TextStyle(fontSize: 16)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16),
              children: const [
                _Menu(icon: Icons.motorcycle, label: 'GoRide'),
                _Menu(icon: Icons.fastfood, label: 'GoFood'),
                _Menu(icon: Icons.local_shipping, label: 'GoSend'),
                _Menu(icon: Icons.account_balance_wallet, label: 'Dompet'),
                _Menu(icon: Icons.shopping_bag, label: 'GoMart'),
                _Menu(icon: Icons.more_horiz, label: 'Lainnya'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Dompet'),
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Menu({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CircleAvatar(radius: 28, backgroundColor: Colors.green.shade100, child: Icon(icon, color: Colors.green)), const SizedBox(height: 6), Text(label)],
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dompet MasJek')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet, size: 65, color: Colors.green),
            SizedBox(height: 12),
            Text('Dompet MasJek', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Saldo: Rp 0 - Login berhasil!'),
          ],
        ),
      ),
    );
  }
}
