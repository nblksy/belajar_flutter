import '../models/product.dart';

List<Product> getProducts(String kategori) {
  if (kategori == "Dustbag Custom Logo") {
    List<String> images = [
      "https://cdn.prod.website-files.com/63f8f02e35d18441043c9041/6480cfc82f9e4bcc00446473_skye-poster.jpg",
      "https://pngtotal.com/wp-content/uploads/2024/09/apollo-paw-patrol-png.png",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQySVI-Aw8qcD_dGup4_yuH1H1V0tp-OUb18g&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyBFZRxqfNQQIX1yDhjyJDFNCrrJX4_68EXw&s",
      "https://cdn.prod.website-files.com/63f8f02e35d18441043c9041/645d48697b3b815ec3862e39_rubble-thumbnail.jpg",
      "https://cdn.prod.website-files.com/63f8f02e35d18441043c9041/645d4850f73d9db4f54ee973_zuma-thumbnail.jpg",
      "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2025-05/paw-patrol-marshall-mc-250513-d17a0d.jpg",
      "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2025-05/paw-patrol-rocky-mc-250513-159b9e.jpg",
      "https://cdn.prod.website-files.com/63f8f02e35d18441043c9041/645d48e28ca0a9562c87eadb_everest-thumbnail.jpg",
      "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2025-05/paw-patrol-liberty-mc-250513-e39fd3.jpg",
    ];

    return List.generate(
      images.length,
      (index) => Product(
        nama: "Custom Logo Premium ${index + 1}",
        deskripsi: "Dustbag bahan kanvas tebal + sablon logo",
        gambar: images[index], // TANPA %
        harga: 15000 + (index * 2000),
      ),
    );
  } else if (kategori == "Dustbag Sepatu") {
    List<String> images = [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo-bg6W0urvd8cyBRZPtFJq54MZVyJwDmefA&s",
      "https://static.wikia.nocookie.net/zonguebob-and-friends/images/c/cf/Patrick.png/revision/latest?cb=20170907204659",
      "https://static.wikia.nocookie.net/characterprofile/images/3/31/1200px-Mr._Krabs.svg.png/revision/latest?cb=20210228113259",
      "https://upload.wikimedia.org/wikipedia/id/thumb/f/f7/SpongeBob_SquarePants_Pearl_Krabs.png/250px-SpongeBob_SquarePants_Pearl_Krabs.png",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbPM4N2IknuHGB3PY6OMC1WDJpouSoC2CRc9Yizp9XqAlJbIO-XOT3wRG91ES-ialKlH6_d6rXzrfNPKcPQEA44IQTXCEHFi6ZRGx23Q&s=10",
      "https://i5.walmartimages.com/asr/8e4efc48-a09b-483e-b459-ff895a2d499b.97880896b79d5609dd3b62aab64ef186.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcbw3G8FNqEd_zqVgxF3PgqFxdGQKdsk_uKa8vo_lvs7_tuXx5dActix60LpHbJ6TvAKxlY1aqpz3BIagLP5ZnX_05kixQYjuVtY-_jQ&s=10",
      "https://static.wikia.nocookie.net/spongebob/images/0/0e/Squidward_Tentacles_stock_art.png/revision/latest?cb=20181202213154&path-prefix=id",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3PJbFShTpo1ZKuQZB_xqVheKVGyY_qRqFBIdEpe4K0QBj87cmOQ-VWmG8pEvh4N_9iql_Htow6kUL_zI0Q1v_a90jBasguhy84952UXQ&s=10",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWX0GIpvZ7sbhsqryxUGKjKxaJjd-dDZXtL_gKGTdHp6OhfVAJ3Cuhyrzn99SStmPfF496pliuhzrUhuOieqWZ_s4J7C9fNfL3H0Ja0NU&s=10",
    ];

    return List.generate(
      images.length,
      (index) => Product(
        nama: "Dustbag Sepatu ${index + 1}",
        deskripsi: "Ukuran 30x40 cm, cocok untuk sneakers",
        gambar: images[index],
        harga: 12000 + (index * 1500),
      ),
    );
  } else {
    List<String> images = [
      "https://static.wikia.nocookie.net/h__/images/e/e1/Manny_Earth_Day02.png/revision/latest?cb=20240926193253&path-prefix=handymanny",
      "https://static.wikia.nocookie.net/h__/images/c/c2/Turner.jpg/revision/latest/smart/width/250/height/250?cb=20240926193253&path-prefix=handymanny",
      "https://toppng.com/uploads/preview/handy-manny-dusty-11548629868zlwqib8msb.png",
      "https://www.clipartmax.com/png/middle/454-4546786_handy-manny-rusty.png",
      "https://static.wikia.nocookie.net/handymannypedia/images/b/b6/Images_%286%29.jpg/revision/latest?cb=20111027210251",
      "https://static.wikia.nocookie.net/h__/images/e/e1/Manny_Earth_Day02.png/revision/latest?cb=20240926193253&path-prefix=handymanny",
      "https://static.wikia.nocookie.net/tayothelittlebus/images/1/14/Gani_clear.png/revision/latest/smart/width/250/height/250?cb=20230126033043",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQLsNTkbXeFp7V97p9Ma1NoOXl0FiXqm3gfQ&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpNXDTDoBWyZ76gOKDF-6g9qs0fxq_gQKVnQ&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJL9Iy51rKJLVoLHjUb8erqTV1q5PI4XXdng&s",
    ];

    return List.generate(
      images.length,
      (index) => Product(
        nama: "Dustbag Tas ${index + 1}",
        deskripsi: "Bahan spunbond premium, kuat & awet",
        gambar: images[index],
        harga: 18000 + (index * 2500),
      ),
    );
  }
}
