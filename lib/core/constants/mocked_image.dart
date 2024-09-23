class MockedImage {
  static const String mockedImageFromS3 =
      "https://highlite-app-dev192643-dev.s3.ap-southeast-2.amazonaws.com/public/profile-photo/1690206877646.png";
  static const List<String> picsum = [
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/seed/picsum/200/300',
    'https://picsum.photos/id/239/200/300?grayscale',
    'https://picsum.photos/id/200/200/300?blur=2',
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/seed/picsum/200/300',
    'https://picsum.photos/id/239/200/300?grayscale',
    'https://picsum.photos/id/200/200/300?blur=2',
  ];
  static const String onePicsum = 'https://picsum.photos/id/237/200/300';
  static List<String> generate(int length) {
    return List.generate(length, (index) => mockedImageFromS3);
  }

  static List<String> generatePicsum(int length) {
    return List.generate(length, (index) => "https://picsum.photos/200/300");
  }

  static const String mockedCompanyImageFromS3 =
      "https://highlite-build225345-build.s3.ap-southeast-2.amazonaws.com/temp/bank.jpeg";

  static const String mockedCompanyJobPost = 
      "https://image.mux.com/sUMPyL7aOtmCNoyCV2BtWDZMvD701Cf4bkFcnfdJbVo8/thumbnail.png?time=0&fit_mode=preserve";
}
