
import 'package:flutter/material.dart';

void main() {
  runApp(const MasJekApp());
}

class MasJekApp extends StatelessWidget {
  const MasJekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MasJek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16A34A),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      home(),
      const WalletScreen(),
      const ActivityScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[page]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (value) {
          setState(() => page = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Dompet',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Aktivitas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget home() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF16A34A),
              child: Icon(
                Icons.motorcycle,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MasJek',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16A34A),
                  ),
                ),
                Text('Dekat, Cepat, Bersahabat'),
              ],
            ),
            Spacer(),
            Icon(Icons.notifications_none),
          ],
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF16A34A),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang di MasJek!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Mau pergi atau pesan sesuatu?',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'Layanan MasJek',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: service(
                'MasRide',
                Icons.motorcycle,
                Colors.green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: service(
                'MasFood',
                Icons.restaurant,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: service(
                'MasSend',
                Icons.local_shipping,
                Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          'Pembayaran',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Card(
          child: ListTile(
            leading: Icon(Icons.payments, color: Colors.green),
            title: Text('Tunai'),
            subtitle: Text('Bayar langsung'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.qr_code, color: Colors.green),
            title: Text('QRIS'),
            subtitle: Text('Pembayaran digital'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: Colors.green,
            ),
            title: Text('Saldo MasJek'),
            subtitle: Text('Dompet digital'),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'MasJek melayani wilayah Banten.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget service(String name, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceScreen(
              name: name,
              icon: icon,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceScreen extends StatelessWidget {
  final String name;
  final IconData icon;

  const ServiceScreen({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 70, color: Colors.green),
            const SizedBox(height: 25),
            Text(
              'Pesan $name',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Lokasi penjemputan',
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Lokasi tujuan',
                prefixIcon: Icon(Icons.place),
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Sistem pemesanan akan segera dihubungkan.',
                      ),
                    ),
                  );
                },
                child: const Text('Lanjutkan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.account_balance_wallet,
              size: 65,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            const Text(
              'Dompet MasJek',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Saldo contoh: Rp0'),
          ],
        ),
      ),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Belum ada aktivitas pesanan'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profil Pengguna MasJek'),
    );
  }
}
