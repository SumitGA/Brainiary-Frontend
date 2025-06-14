import 'package:flutter/material.dart';
import 'auth_screen.dart';

class LandingPage extends StatelessWidget {
  final List<ServiceItem> services = [
    ServiceItem('Resume Generator', Icons.description_outlined, '/home'),
    ServiceItem('Main Screen', Icons.home_outlined, '/main'),
    ServiceItem('Resume Results', Icons.assignment_outlined, '/resume-result'),
    ServiceItem('Document Tools', Icons.transform_outlined, '/converter'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          _buildHeader(context),

          const SizedBox(height: 6),

          // Body - Scrollable content
          Expanded(child: SingleChildScrollView(child: _buildBody(context))),

          // Footer
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo/Brand
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0XFF263238),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.business, color: Colors.white, size: 20)
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                'Brainiary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF263238),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Navigation and Login
          if (isWide) ...[
            _buildNavItems(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                },
                icon: const Icon(Icons.login, size: 16),
                label: const Text("Login"),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0XFF263238),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                ),
              ),
            )
          ] else ...[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _showMobileMenu(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItems(BuildContext context) {
    return Row(
      children: services
          .map(
            (service) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextButton.icon(
                onPressed: () => _navigateToService(context, service.route),
                icon: Icon(service.icon, size: 16),
                label: Text(service.name),
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF263238),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Hero Section
          _buildHeroSection(context),

          // Services Grid
          _buildServicesGrid(context),

          // Features Section
          _buildFeaturesSection(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5F7FA), Colors.white],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'Professional Resume Builder\n& Document Services',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Color(0xFF263238),
              height: 1.2,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Create professional resumes with ease.\nPowerful tools designed for success.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF546E7A),
              height: 1.5,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => _navigateToService(context, '/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF263238),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: Text(
              'Build Resume Now',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            'Our Services',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263238),
            ),
          ),
          SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 768 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _buildServiceCard(context, service);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceItem service) {
    return GestureDetector(
      onTap: () => _navigateToService(context, service.route),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(service.icon, color: Color(0xFF263238), size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Professional ${service.name.toLowerCase()} tools',
                    style: TextStyle(color: Color(0xFF546E7A), fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      color: Color(0xFFF8FAFC),
      child: Column(
        children: [
          Text(
            'Why Choose Brainiary?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263238),
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: _buildFeatureItem('Fast & Reliable', Icons.speed),
              ),
              Expanded(
                child: _buildFeatureItem('Easy to Use', Icons.touch_app),
              ),
              Expanded(
                child: _buildFeatureItem('Professional', Icons.security),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFF263238), size: 48),
        SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF263238),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Color(0xFF263238),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Privacy Policy', style: TextStyle(color: Colors.white70)),
              Text('Terms of Service', style: TextStyle(color: Colors.white70)),
              Text('Contact Us', style: TextStyle(color: Colors.white70)),
            ],
          ),
          SizedBox(height: 16),
          Text(
            '© 2025 Brainiary. All rights reserved.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: services
              .map(
                (service) => ListTile(
                  leading: Icon(service.icon),
                  title: Text(service.name),
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToService(context, service.route);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _navigateToService(BuildContext context, String route) {
    // Navigate to your actual screens
    Navigator.pushNamed(context, route);
  }
}

class ServiceItem {
  final String name;
  final IconData icon;
  final String route;

  ServiceItem(this.name, this.icon, this.route);
}
