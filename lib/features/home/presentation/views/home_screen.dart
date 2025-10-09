import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laza_ecommerce/core/utiles/color_utiles.dart';
import 'package:laza_ecommerce/features/home/domain/entities/product_entity.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/category_cubit/category_state.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/product_cubit/product_state.dart';
import 'package:laza_ecommerce/features/home/presentation/widgets/product_card.dart';
import 'package:laza_ecommerce/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildHeader(context),
              SizedBox(height: 20.h),
              Text(
                AppLocalizations.of(context)!.hello,
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                AppLocalizations.of(context)!.welcomeToLaza,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorUtility.colorGray,
                ),
              ),

              SizedBox(height: 20.h),
              _buildSearchBar(context),
              SizedBox(height: 20.h),
              _buildSectionHeader(
                AppLocalizations.of(context)!.categories,
                context,
              ),
              SizedBox(height: 10.h),
              _buildCategorySection(),
              SizedBox(height: 20.h),
              _buildSectionHeader(
                AppLocalizations.of(context)!.newArrival,
                context,
              ),
              SizedBox(height: 10.h),
              _buildNewArrivalsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is GetCategoryLoading || state is CategoryInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCategorySuccess) {
          return _buildCategoryList(state.categories);
        } else if (state is GetCategoryFailure) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNewArrivalsSection() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading || state is ProductInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Productsuccess) {
          return _buildNewArrivalGrid(state.products);
        } else if (state is ProductFailure) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  // All other helper methods now use ScreenUtil for responsive sizing

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/svg/menu.svg",
            colorFilter: const ColorFilter.mode(
              Color(0xff1D1E20),
              BlendMode.srcIn,
            ),
            width: 30.r,
            height: 30.r,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        IconButton(
          icon: Icon(
            Icons.shopping_bag_outlined,
            // color: Color(0xff1D1E20),
            size: 30.r,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.search,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15.sp),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  'assets/svg/Vector.svg',
                  height: 10,
                  width: 10,
                ),
              ),

              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          decoration: BoxDecoration(
            color: ColorUtility.mainColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: IconButton(
            icon: Icon(Icons.mic, color: Colors.white, size: 24.r),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            AppLocalizations.of(context)!.viewAll,
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(categories) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              context.read<ProductCubit>().getProducts(category.id);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      category.coverPictureUrl,
                      width: 40.r,
                      height: 40.r,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Center(
                    child: Text(
                      category.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewArrivalGrid(List<ProductEntity> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
