class Food {
  const Food({
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.rating,
    required this.minutes,
    required this.calories,
    required this.description,
  });

  final String name;
  final String image;
  final String category;
  final double price;
  final double rating;
  final int minutes;
  final int calories;
  final String description;
}

const categories = [
  'All',
  'Burgers',
  'Italian',
  'Asian',
  'Mexican',
  'Healthy',
  'Desserts',
];

const categoryImages = {
  'All': 'assets/food/drink.png',
  'Burgers': 'assets/food/burger.png',
  'Italian': 'assets/food/pizza.png',
  'Asian': 'assets/food/sushi.png',
  'Mexican': 'assets/food/taco.png',
  'Healthy': 'assets/food/salad.png',
  'Desserts': 'assets/food/cake.png',
};

const foods = [
  Food(
    name: 'Classic Burger',
    image: 'assets/food/burger.png',
    category: 'Burgers',
    price: 8.90,
    rating: 4.8,
    minutes: 20,
    calories: 640,
    description:
        'Juicy beef patty, cheddar, fresh lettuce and our secret sauce in a toasted sesame bun.',
  ),
  Food(
    name: 'Pepperoni Pizza',
    image: 'assets/food/pizza.png',
    category: 'Italian',
    price: 12.50,
    rating: 4.9,
    minutes: 25,
    calories: 820,
    description:
        'Stone baked, thin crust, mozzarella and spicy pepperoni from edge to edge.',
  ),
  Food(
    name: 'Salmon Sushi',
    image: 'assets/food/sushi.png',
    category: 'Asian',
    price: 14.00,
    rating: 4.7,
    minutes: 30,
    calories: 380,
    description:
        'Fresh salmon on seasoned rice, served with soy sauce, ginger and wasabi.',
  ),
  Food(
    name: 'Crunchy Taco',
    image: 'assets/food/taco.png',
    category: 'Mexican',
    price: 6.50,
    rating: 4.6,
    minutes: 15,
    calories: 420,
    description:
        'Crispy shell, seasoned beef, salsa, cheese and a squeeze of lime.',
  ),
  Food(
    name: 'Spicy Ramen',
    image: 'assets/food/ramen.png',
    category: 'Asian',
    price: 11.50,
    rating: 4.8,
    minutes: 25,
    calories: 560,
    description:
        'Rich broth, springy noodles, soft egg and a kick of chili oil.',
  ),
  Food(
    name: 'Strawberry Cake',
    image: 'assets/food/cake.png',
    category: 'Desserts',
    price: 5.90,
    rating: 4.9,
    minutes: 10,
    calories: 350,
    description:
        'Soft vanilla sponge with fresh cream and real strawberries.',
  ),
  Food(
    name: 'Green Salad',
    image: 'assets/food/salad.png',
    category: 'Healthy',
    price: 7.90,
    rating: 4.5,
    minutes: 10,
    calories: 210,
    description:
        'Crisp greens, cherry tomatoes and a light lemon dressing.',
  ),
  Food(
    name: 'Spaghetti',
    image: 'assets/food/spaghetti.png',
    category: 'Italian',
    price: 10.90,
    rating: 4.7,
    minutes: 20,
    calories: 610,
    description:
        'Slow cooked tomato sauce, meatballs and a snow of parmesan.',
  ),
  Food(
    name: 'Crispy Fries',
    image: 'assets/food/fries.png',
    category: 'Burgers',
    price: 3.90,
    rating: 4.6,
    minutes: 10,
    calories: 320,
    description: 'Golden, crispy outside, fluffy inside. Lightly salted.',
  ),
  Food(
    name: 'Beef Burrito',
    image: 'assets/food/burrito.png',
    category: 'Mexican',
    price: 9.50,
    rating: 4.7,
    minutes: 20,
    calories: 720,
    description: 'Beef, rice, beans, cheese and salsa, wrapped and grilled.',
  ),
  Food(
    name: 'Glazed Donut',
    image: 'assets/food/donut.png',
    category: 'Desserts',
    price: 2.90,
    rating: 4.8,
    minutes: 10,
    calories: 290,
    description: 'Chocolate glaze and rainbow sprinkles on a fluffy donut.',
  ),
  Food(
    name: 'Ice Cream',
    image: 'assets/food/icecream.png',
    category: 'Desserts',
    price: 3.50,
    rating: 4.9,
    minutes: 10,
    calories: 240,
    description: 'Creamy vanilla soft serve in a crunchy waffle cone.',
  ),
];
