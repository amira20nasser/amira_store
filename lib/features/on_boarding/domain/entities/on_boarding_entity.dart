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
      image: Assets.assetsImagesIllustration0,
      imageDarkTheme: Assets.assetsImagesIllustrationDarkTheme0,
      title: "Various Collections of The Latest Products",
      description:
          "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesIllustration1,
      imageDarkTheme: Assets.assetsImagesIllustrationDarkTheme1,

      title: "Get those shopping \nbags filled",
      description:
          "Add any item you want to your cart, or save it on your wishlist, so you don’t miss it in your future purchases.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesIllustration2,
      imageDarkTheme: Assets.assetsImagesIllustrationDarkTheme2,

      title: "Fast & secure \npayment",
      description: "There are many payment options available for your ease.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesIllustration3,
      imageDarkTheme: Assets.assetsImagesIllustrationDarkTheme3,

      title: "Package tracking",
      description:
          "In particular, Amira's Store can pack your orders, and help you seamlessly manage your shipments.",
    ),
    OnBoardingEntity(
      image: Assets.assetsImagesIllustration4,
      imageDarkTheme: Assets.assetsImagesIllustrationDarkTheme4,

      title: "Nearby stores",
      description:
          "Easily track nearby shops, browse through their items and get information about their prodcuts.",
    ),
  ];
}
