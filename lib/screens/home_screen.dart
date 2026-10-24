import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/food.dart';
import '../theme.dart';
import '../widgets/cart_button.dart';
import '../widgets/category_chips.dart';
import '../widgets/fade_slide.dart';
import '../widgets/fly_to_cart.dart';
import '../widgets/food_card.dart';
import '../widgets/promo_banner.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _category = 0;
  final _cartKey = GlobalKey();

  List<Food> get _visible => _category == 0
      ? foods
      : foods.where((f) => f.category == categories[_category]).toList();

  void _addToCart(Food food, GlobalKey imageKey) {
    final imageBox = imageKey.currentContext!.findRenderObject() as RenderBox;
    final cartBox = _cartKey.currentContext!.findRenderObject() as RenderBox;
    flyToCart(
      context: context,
      image: food.image,
      from: imageBox.localToGlobal(Offset.zero) & imageBox.size,
      to: cartBox.localToGlobal(cartBox.size.center(Offset.zero)),
      onArrive: () => CartScope.of(context).add(food),
    );
  }

  void _openDetail(Food food) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, _, _) => DetailScreen(food: food),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _visible;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  FadeSlide(child: _header()),
                  const SizedBox(height: 22),
                  const FadeSlide(
                    delay: 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'What would you\nlike to eat today?',
                        style: TextStyle(fontSize: 28, height: 1.15, fontWeight: FontWeight.w800, color: ink),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  FadeSlide(delay: 200, child: _searchBar()),
                  const SizedBox(height: 22),
                  const FadeSlide(delay: 300, child: PromoBanner()),
                  const SizedBox(height: 24),
                  FadeSlide(
                    delay: 400,
                    child: CategoryChips(
                      selected: _category,
                      onSelect: (i) => setState(() => _category = i),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              sliver: SliverGrid.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, i) => FadeSlide(
                  key: ValueKey('${items[i].name}-$_category'),
                  delay: 80 * i,
                  child: FoodCard(
                    food: items[i],
                    onTap: () => _openDetail(items[i]),
                    onAdd: (imageKey) => _addToCart(items[i], imageKey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.location_on_rounded, color: orange),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Deliver to', style: TextStyle(fontSize: 12, color: grey, fontWeight: FontWeight.w500)),
                SizedBox(height: 2),
                Text('Home, 21 Baker St', style: TextStyle(fontSize: 15, color: ink, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          CartButton(
            key: _cartKey,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Row(
          children: [
            Icon(Icons.search_rounded, color: grey),
            SizedBox(width: 10),
            Text('Search burgers, pizza, sushi...', style: TextStyle(color: grey, fontSize: 14)),
            Spacer(),
            Icon(Icons.tune_rounded, color: orange),
          ],
        ),
      ),
    );
  }
}
