import '../../../../core/constants/image_assets.dart';

class OnBoardingEntity {
  final String image, title, description;
  final String imageDarkTheme;

  OnBoardingEntity({
    required this.image,
    required this.title,
    this.description = "",
    required this.imageDarkTheme,
  });

  static final getItems = [
    OnBoardingEntity(
      image: Assets.assetsImagesBoardingIllustration0,
      imageDarkTheme: Assets.assetsImagesBoardingIllustrationDarkTheme0,
      title: "Various Collections of The Latest Products",
      description:
          "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesBoardingIllustration1,
      imageDarkTheme: Assets.assetsImagesBoardingIllustrationDarkTheme1,

      title: "Get those shopping \nbags filled",
      description:
          "Add any item you want to your cart, or save it on your wishlist, so you don’t miss it in your future purchases.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesBoardingIllustration2,
      imageDarkTheme: Assets.assetsImagesBoardingIllustrationDarkTheme2,

      title: "Fast & secure \npayment",
      description: "There are many payment options available for your ease.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesBoardingIllustration3,
      imageDarkTheme: Assets.assetsImagesBoardingIllustrationDarkTheme3,

      title: "Package tracking",
      description:
          "In particular, Amira's Store can pack your orders, and help you seamlessly manage your shipments.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesBoardingIllustration4,
      imageDarkTheme: Assets.assetsImagesBoardingIllustrationDarkTheme4,

      title: "Nearby stores",
      description:
          "Easily track nearby shops, browse through their items and get information about their prodcuts.",
    ),
  ];
}
