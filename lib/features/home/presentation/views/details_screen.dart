import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_button_nav_bar.dart';
import 'package:laza_ecommerce/features/home/domain/entities/product_entity.dart';
import 'package:laza_ecommerce/features/home/presentation/widgets/reviews_item.dart';
import 'package:laza_ecommerce/features/review/presentation/views/reviews_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;
  int _selectedColorIndex = 0;

  final List<Color> _colors = [
    Colors.tealAccent,
    Colors.blueAccent,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 30.r,
            width: 30.r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        title: Text(widget.product.name),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20.r),
            icon: Icon(Icons.shopping_bag_outlined, size: 30.r),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageCarousel(),
                  const SizedBox(height: 20),
                  _buildProductInfo(),
                  const SizedBox(height: 20),
                  _buildColorSelector(),
                  const SizedBox(height: 20),
                  _buildSizeSelector(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  const SizedBox(height: 24),
                  _buildReviewsSection(),
                  const SizedBox(height: 24), // مسافة جديدة
                  _buildTotalPriceSection(), // <-- الجزء الجديد الثاني
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomButtonNavBar(
        label: '',
        textFixed: 'Add to Cart',
        onTap: () {
          if (_selectedSize == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select a size first!")),
            );
          } else {
            // Add to cart logic here
            print(
              "Added to cart: ${widget.product.name}, Size: $_selectedSize, Color: ${_colors[_selectedColorIndex]}",
            );
          }
        },
      ),
    );
  }

  Widget _buildImageCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        autoPlay: false,
        enlargeCenterPage: true,
      ),
      items: [widget.product.imageUrl].map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            String correctedImageUrl =
                imageUrl ?? 'https://picsum.photos/seed/shoes/300/300';
            if (imageUrl ==
                'https://upload.wikimedia.org/wikipedia/commons/6/6a/Gucci_Logo.svg') {
              correctedImageUrl =
                  'https://upload.wikimedia.org/wikipedia/commons/a/a4/Gucci_Logo.svg';
            }
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                correctedImageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 4.5, // Dummy data
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {},
                  ignoreGestures: true,
                ),
                const SizedBox(width: 8),
                const Text("(10 Reviews)"), // Dummy data
              ],
            ),
            Text(
              "\$${widget.product.price.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color:",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(_colors.length, (index) {
            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = index),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _colors[index],
                  border: Border.all(
                    color: _selectedColorIndex == index
                        ? Colors.teal
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: _colors[index],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSizeSelector() {
    final List<String> availableSizes = ["S", "M", "L", "XL", "2XL"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size:",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10.0,
          children: availableSizes.map((size) {
            final isSelected = _selectedSize == size;
            return ChoiceChip(
              label: Text(size),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedSize = selected ? size : null;
                });
              },
              selectedColor: Colors.teal,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description:",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.product.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewsScreen(productId: widget.product.id),
                  ),
                );
              },
              child: const Text("View All"),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Single Review Card (Dummy Data)
        ReviewsItem(
          backgroundImage: 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
          name: 'Ronald Richards',
          rating: '4.8 rating',
          date: '13 Sep, 2020',
          comment:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...',
        ),
      ],
    );
  }

  Widget _buildTotalPriceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Price",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("with VAT, SD", style: TextStyle(color: Colors.grey)),
          ],
        ),
        Text(
          "\$${widget.product.price.toStringAsFixed(2)}", // Using product price
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ],
    );
  }
}

