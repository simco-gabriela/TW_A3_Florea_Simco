-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.3.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for webgardening
CREATE DATABASE IF NOT EXISTS `webgardening` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `webgardening`;

-- Dumping structure for table webgardening.blogs
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` longtext NOT NULL,
  `image_url` varchar(150) NOT NULL,
  `author_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_blogs_author` (`author_id`),
  CONSTRAINT `FK_blogs_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.blogs: ~6 rows (approximately)
INSERT IGNORE INTO `blogs` (`id`, `title`, `content`, `image_url`, `author_id`, `date`, `description`) VALUES
	(1, 'How to Capture Stunning Flower Photos for Your Online Store', 'If you’re looking to enhance the visual appeal of your floral inventory online, great photography can make all the difference. Capturing the true beauty of your flowers not only attracts more customers but also significantly boosts your sales. Here are some professional techniques to help you take breathtaking photos that will make your flowers look irresistible online.\n\n1. Utilize Natural Light\nThe best lighting for flower photography is natural light. Aim to take your photos during the golden hours—shortly after sunrise or before sunset—when the light is soft and warm. This kind of lighting accentuates the natural colors and textures of the flowers without causing harsh shadows or overexposure.\n\n2. Choose the Right Background\nA simple, uncluttered background highlights the beauty of the flowers. Use a solid color or a subtle pattern that complements the flowers without competing for attention. This helps the viewer focus solely on the product.\n\n3. Experiment with Angles\nDifferent angles can dramatically change the perception of your flowers. Try taking photos from above, at a 45-degree angle, and at level with the flower to capture various dimensions and details. Each angle offers a unique perspective, so experiment to see which showcases your flowers best.\n\n4. Focus on Details\nClose-up shots that focus on details like the texture of the petals, the color gradients, and the intricacies of the stem can make for compelling images. Such images invite the viewer to take a closer look and appreciate the fine details of your flowers.\n\n5. Use a Proper Lens\nIf possible, use a macro lens for close-up photography. This type of lens allows you to get detailed shots without losing clarity. For wider shots, a standard lens should suffice, ensuring that the entire bouquet or arrangement is in focus.\n\n6. Consider the Composition\nPay attention to the composition of your shots. The rule of thirds is a basic principle that can help you balance your photos. Position the main elements of the bouquet off-center to create a more interesting and dynamic composition.\n\n7. Edit Thoughtfully\nPost-processing is essential but should be used sparingly. Adjust the brightness, contrast, and saturation to enhance the photo without making it look unnatural. Remember, the goal is to make the flowers look their best while still appearing real.\n\nBy following these tips, you can capture stunning, sales-worthy photographs of your flowers. With high-quality images, your online store will not only draw attention but also give your customers a closer, more attractive look at your beautiful inventory.', 'images/blog-image-1.jpg', 5, '2024-04-14', 'Emily Thorn shares professional techniques for taking breathtaking photos of your flowers. Discover the best lighting, angles, and setups to make your floral inventory look irresistible online, boosting appeal and sales.'),
	(2, 'The Dirt on Soil: Ensuring Optimal Health for Your Spring Blooms\n', 'Spring is a critical time for gardeners, and the health of your soil is the foundation of a vibrant garden. As the saying goes, "Take care of the dirt, and the dirt will take care of your plants." Here\'s how you can test, amend, and maintain your soil to ensure that your tulips, daffodils, and other spring flowers thrive.\n\n1. Testing Your Soil\nBefore you begin planting, it’s essential to understand the current condition of your soil. Soil testing kits are readily available at garden centers and online. These tests provide valuable information about the pH level and the presence of vital nutrients like nitrogen, phosphorus, and potassium. For a more comprehensive analysis, consider sending a soil sample to a local agricultural extension service.\n\n2. Amending Your Soil\nOnce you have your soil test results, it’s time to amend the soil according to the needs of your plants. If your soil is too acidic, adding lime can help balance the pH. Conversely, if it\'s too alkaline, sulfur may be needed to lower the pH. To improve soil fertility, incorporate organic matter such as compost, manure, or leaf mold. These amendments not only enrich the soil but also improve its structure, drainage, and water-holding capacity.\n\n3. Choosing the Right Fertilizer\nFertilizers can provide additional nutrients to your soil, but choosing the right type is crucial. Opt for a balanced, slow-release fertilizer that will provide nutrients gradually throughout the growing season. Be cautious with chemical fertilizers, as overuse can harm plant roots and disrupt soil microbiology. Whenever possible, choose organic fertilizers—they are better for your plants and the environment.\n\n4. Mulching for Moisture and Health\nMulch is not just a decorative element—it\'s vital for maintaining soil health. A good layer of mulch (about 2-3 inches) can help retain soil moisture, suppress weeds, and regulate soil temperature. Organic mulches like bark, straw, or grass clippings also break down over time, further enriching the soil.\n\n5. Regular Maintenance\nSoil health is not a one-time task but an ongoing commitment. Regularly check the moisture level of your soil, especially during dry spells, and water accordingly. Avoid compacting the soil by walking on it excessively or using heavy machinery. Keep an eye on your plants for signs of nutrient deficiencies or other soil problems, and adjust your soil management practices as needed.', 'images/blog-image-2.jpg', 2, '2024-04-12', 'Find out the essentials of soil management for vibrant spring gardens. Learn how to test, amend, and maintain your soil to ensure your tulips, daffodils, and other spring flowers thrive.'),
	(3, 'A Gardener\'s Guide to Fertilizer: Boosting Your Blooms the Right Way', 'Fertilizer is a key ingredient in any gardener\'s toolkit, especially when the goal is to maximize the bloom potential of spring flowers. Understanding the different types of fertilizers and their benefits can help you find the perfect match for your garden\'s needs. Here\'s a straightforward guide to getting the most out of your fertilizer to ensure vibrant and healthy blooms.\n\n1. Understanding Fertilizer Types\nFertilizers come in various forms, each with specific advantages:\n\nGranular Fertilizers: Slow-releasing and easy to apply, granular fertilizers release nutrients over time, providing a steady supply of nutrition to your plants.\nLiquid Fertilizers: Quick-acting and ideal for addressing nutrient deficiencies rapidly, liquid fertilizers are perfect for a mid-season boost.\nOrganic Fertilizers: Made from natural materials such as compost, manure, or bone meal, organic fertilizers improve soil structure while feeding your plants.\nSynthetic Fertilizers: These are formulated to provide an immediate supply of nutrients and are often used for their precise nutrient ratios.\n2. Selecting the Right Nutrient Mix\nFertilizers are labeled with three numbers, representing the proportions of nitrogen (N), phosphorus (P), and potassium (K), respectively — crucial nutrients for plant health:\n\nNitrogen (N): Promotes leafy growth and is essential for the vibrant green color of plants.\nPhosphorus (P): Encourages root development, flower, and fruit production.\nPotassium (K): Aids in overall plant health and disease resistance.\nFor flowering plants, choose a fertilizer with a higher phosphorus content to encourage more blooms.\n\n3. Timing Is Everything\nThe timing of fertilizer application is critical. Apply fertilizers early in the season to kick-start growth, and consider a mid-season application to support blooming. Always avoid fertilizing late in the season as this can lead to new growth that is vulnerable to frost.\n\n4. Application Methods\nFertilizer can be applied in several ways, depending on the type and the specific needs of your garden:\n\nBroadcasting: Spreading fertilizer evenly over the soil surface, followed by a thorough watering.\nSide-dressing: Applying fertilizer alongside your plants to target their root systems more directly.\nFoliar Feeding: Spraying liquid fertilizer directly onto the leaves for quick absorption.\n5. Consider the Environment\nAlways consider the environmental impact of your fertilizing habits. Over-fertilization can lead to nutrient runoff, which pollutes local waterways. Use the recommended amounts, and opt for organic fertilizers whenever possible to minimize environmental impact.', 'images/blog-image-3.jpg', 3, '2024-04-10', 'Maximize the bloom potential of your spring flowers with the right fertilizer. Learn about different types and their benefits to find the best match for your gardening needs.'),
	(4, 'Growing Tulips May be Easier than You Think', 'Tulips are among the most beloved spring flowers, renowned for their vibrant colors and graceful shapes. If you\'re a beginner gardener looking to add a splash of color to your garden this spring, growing tulips can be surprisingly straightforward. Here are some easy-to-follow tips and tricks to help you grow beautiful tulips with minimal fuss.\n\n1. Choose the Right Bulbs\nSelecting high-quality bulbs is the first step to growing great tulips. Look for plump, firm bulbs without any signs of damage or mold. The larger the bulb, the larger the bloom will likely be, so consider this when making your purchase.\n\n2. Plant at the Right Time\nTulip bulbs should be planted in the fall, before the ground freezes. In most climates, this means planting in September or October. Planting at this time allows the bulbs to establish roots before the winter.\n\n3. Find the Perfect Spot\nTulips thrive in a spot with full to partial sunlight. They also prefer well-drained soil, as standing water can cause the bulbs to rot. If your soil is heavy or clayey, consider amending it with sand or planting your bulbs in raised beds or well-draining containers.\n\n4. Planting Depth and Spacing\nAs a general rule, plant tulip bulbs about three times as deep as the bulb is tall. This typically means planting them about 4 to 6 inches deep with about 4 to 5 inches between each bulb. Planting them at the right depth helps protect them from temperature fluctuations and provides stability as the flowers grow.\n\n5. Water and Mulch\nAfter planting, water your bulbs thoroughly to help settle the soil around them. While tulips are relatively drought-tolerant once established, they do need some water to help them get started. Applying a layer of mulch can help retain moisture and keep weeds at bay, as well as protect the bulbs from extreme cold.\n\n6. Fertilize Wisely\nWhen your tulips begin to sprout in the spring, consider applying a balanced, slow-release fertilizer to encourage healthy growth. Avoid over-fertilizing, as too much nitrogen can promote leaf growth at the expense of flowers.\n\n7. After Bloom Care\nOnce your tulips have bloomed, resist the urge to cut down the foliage. The leaves should be allowed to die back naturally, as they provide the nutrients for next year\'s growth. Only remove leaves when they have yellowed and withered.', 'images/blog-image-4.jpg', 4, '2024-04-09', 'Simplify the process of growing tulips this spring with easy-to-follow tips and tricks. Ideal for beginners looking to add a splash of color to their gardens with minimal fuss.'),
	(5, 'Starting Plants from Seed Adds to the Pleasure\n', 'Starting your garden from seeds is not just a practical approach to gardening—it\'s a rewarding journey that allows you to witness the miracle of life from the very first sprout. Whether you\'re planning to grow vibrant spring flowers or hearty vegetables, here are some essential tips to help you successfully germinate and nurture your plants from seed.\n\n1. Choose the Right Seeds\nSelect high-quality seeds from reputable suppliers to increase your chances of successful germination. Consider starting with beginner-friendly seeds that are known for their high germination rates and robust growth, such as marigolds, sunflowers, or lettuce.\n\n2. Use the Proper Starting Mix\nSeeds do best in a soil-less starting mix that is light and sterile to prevent disease problems. These mixes provide excellent drainage and space for delicate roots to grow. Avoid using garden soil, as it can be too heavy and may contain pathogens harmful to young plants.\n\n3. Sow Seeds at the Correct Depth\nA general rule of thumb for planting seeds is to sow them at a depth twice the diameter of the seed. Some tiny seeds, such as petunias, need light to germinate and should be sown directly on the surface of the soil.\n\n4. Maintain Consistent Moisture\nSeeds need consistent moisture to germinate successfully. Keep the soil moist but not waterlogged. Covering your seed trays or pots with plastic wrap can help retain moisture and create a mini greenhouse effect, speeding up germination.\n\n5. Provide Plenty of Light\nAfter seeds sprout, they need plenty of light to grow strong and healthy. Place seedlings near a sunny window or under grow lights. Ensure that the light source is close enough to prevent seedlings from becoming leggy and weak.\n\n6. Regulate Temperature\nMost seeds germinate best at temperatures between 65°F and 75°F (18°C and 24°C). Some may require warmer conditions. Use a heat mat if your growing area is too cool, especially for warmth-loving plants.\n\n7. Transplant Carefully\nOnce your seedlings have developed their first set of true leaves, they are ready to be transplanted. Be gentle during the transplanting process to avoid damaging the delicate roots. Gradually acclimate them to outdoor conditions before planting them out in the garden.\n\n8. Keep Records\nKeeping a gardening journal can be incredibly helpful. Record when you planted the seeds, when they germinated, and any other observations. This record can be a valuable resource for refining your techniques in future seasons.', 'images/blog-image-5.jpg', 6, '2024-04-08', 'Discover the joys and rewards of starting your garden from seeds. Cosmin\'s post provides guidance on how to successfully germinate and nurture your spring flowers from the very beginning.'),
	(6, 'Green Thumbs Go Digital: A User\'s Guide to our Web Gardening application', 'In today’s digital age, gardening too has taken a technological leap forward. Our all-in-one gardening web application is designed to blend a comprehensive shop with advanced growth tracking functionalities, offering you a streamlined gardening process directly from your device. Here’s a detailed guide on how this innovative tool can enhance your gardening experience, making it more efficient, productive, and enjoyable.\n\n1. Managing Multiple Crops\nOur application allows you to manage several crops of spring flowers like tulips, hyacinths, and daffodils simultaneously. With an intuitive dashboard, you can easily add new crops, track their progress, and receive timely recommendations based on the specific growth stages of each plant.\n\n2. Sensor Integration\nThe app integrates seamlessly with a range of sensors that monitor soil moisture, ambient temperature, and other vital environmental variables. This real-time data is crucial for making informed decisions about your garden’s needs. For example, if the soil moisture levels drop below a certain point, the app will recommend optimal watering times and quantities.\n\n3. Image Stream Analysis\nA unique feature of our application is the image stream analysis. By processing images of your crops, the app can determine the health and growth stage of your plants. This technology allows us to predict the perfect harvesting time, ensuring that you can plan your sales when your flowers are at their best.\n\n4. Optimized Sales Process\nFor those looking to sell their blooms, our app not only helps in growing your flowers but also assists in selling them. Interested buyers can register their interest and will be notified through email and browser notifications as soon as their desired flowers are ready for purchase. This direct link between production and sale maximizes efficiency and reduces the wait time for customers.\n\n5. Customizable Notifications\nStay updated with customizable notifications on your desktop or mobile device. Whether it\'s time to water your plants or adjust the greenhouse temperature, these timely alerts ensure that you’re always in sync with your garden\'s needs without needing to constantly check the app.\n\n6. Educational Resources\nFor both novice and experienced gardeners, our application provides a wealth of educational resources. From detailed articles about specific flower care to interactive tutorials on using the application, you’ll find plenty of materials to help you grow as a gardener.\n\n7. Community Features\nEngage with a community of like-minded enthusiasts directly within the app. Share tips, discuss gardening techniques, and even sell or trade flowers with others who share your passion for gardening.', 'images/blog-image-6.jpg', 1, '2024-04-06', 'Join us for a comprehensive review of the latest all-in-one gardening web application that blends a shop, growth tracker and more functionalities. Discover how this tool can streamline your gardening process from the comfort of your online experience.');

-- Dumping structure for table webgardening.blogs_comments
CREATE TABLE IF NOT EXISTS `blogs_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `date` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_blog_comm_blog_id` (`blog_id`),
  KEY `FK_blog_comm_user_id` (`user_id`),
  CONSTRAINT `FK_blog_comm_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_blog_comm_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.blogs_comments: ~2 rows (approximately)
INSERT IGNORE INTO `blogs_comments` (`id`, `blog_id`, `user_id`, `content`, `date`) VALUES
	(1, 1, 3, 'So useful! Will be using for sure!', '2024-05-21 07:51:47'),
	(2, 6, 6, 'We were waiting for this! Thanks!', '2024-05-14 12:30:00');

-- Dumping structure for table webgardening.blogs_likes
CREATE TABLE IF NOT EXISTS `blogs_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_blogs_likes_blogs_id` (`blog_id`),
  KEY `FK_blogs_likes_user_id` (`user_id`),
  CONSTRAINT `FK_blogs_likes_blogs_id` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_blogs_likes_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.blogs_likes: ~7 rows (approximately)
INSERT IGNORE INTO `blogs_likes` (`id`, `blog_id`, `user_id`) VALUES
	(1, 1, 2),
	(2, 1, 3),
	(3, 6, 1),
	(4, 6, 3),
	(5, 5, 4),
	(6, 5, 6),
	(7, 5, 2);

-- Dumping structure for table webgardening.blogs_tags
CREATE TABLE IF NOT EXISTS `blogs_tags` (
  `blog_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  KEY `FK_blogs_tags_blog_id` (`blog_id`),
  KEY `FK_blogs_tags_tag_id` (`tag_id`),
  CONSTRAINT `FK_blogs_tags_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_blogs_tags_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.blogs_tags: ~14 rows (approximately)
INSERT IGNORE INTO `blogs_tags` (`blog_id`, `tag_id`) VALUES
	(1, 1),
	(1, 2),
	(2, 3),
	(2, 4),
	(3, 5),
	(3, 4),
	(3, 6),
	(4, 7),
	(4, 4),
	(5, 8),
	(5, 4),
	(5, 9),
	(6, 10),
	(6, 4);

-- Dumping structure for table webgardening.cart
CREATE TABLE IF NOT EXISTS `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `added_on` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cart_user_id` (`user_id`),
  KEY `FK_cart_product_id` (`product_id`),
  CONSTRAINT `FK_cart_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.cart: ~2 rows (approximately)
INSERT IGNORE INTO `cart` (`id`, `user_id`, `product_id`, `quantity`, `added_on`) VALUES
	(1, 6, 1, 2, '2024-06-05'),
	(2, 6, 2, 3, '2024-06-03');

-- Dumping structure for table webgardening.gardens
CREATE TABLE IF NOT EXISTS `gardens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `created_on` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gardens_user_id` (`user_id`),
  CONSTRAINT `FK_gardens_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.gardens: ~0 rows (approximately)

-- Dumping structure for table webgardening.inbox
CREATE TABLE IF NOT EXISTS `inbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  `type` varchar(256) DEFAULT NULL,
  `timestamp` timestamp NOT NULL,
  `sender` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_inbox_user_id` (`user_id`),
  CONSTRAINT `FK_inbox_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.inbox: ~0 rows (approximately)

-- Dumping structure for table webgardening.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT '',
  `date` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_orders_user_id` (`user_id`),
  CONSTRAINT `FK_orders_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.orders: ~0 rows (approximately)

-- Dumping structure for table webgardening.orders_details
CREATE TABLE IF NOT EXISTS `orders_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ord_det_ord_id` (`order_id`),
  KEY `FK_ord_det_prod_id` (`product_id`),
  CONSTRAINT `FK_ord_det_ord_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ord_det_prod_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.orders_details: ~0 rows (approximately)

-- Dumping structure for table webgardening.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` longtext DEFAULT NULL,
  `image_url` varchar(150) NOT NULL,
  `price` float NOT NULL,
  `available` bit(1) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_product_seller_id` (`seller_id`),
  CONSTRAINT `FK_product_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.products: ~21 rows (approximately)
INSERT IGNORE INTO `products` (`id`, `seller_id`, `name`, `description`, `image_url`, `price`, `available`, `type`, `category`, `color`) VALUES
	(1, 3, 'Beautiful Light Pink Peonies', NULL, 'images/flower-example.jpg', 10, b'1', 'Peony', 'Single stem', 'Pink'),
	(2, 3, 'Blooming Lilac', NULL, 'images/flower-example-lilac.jpg', 8, b'1', 'Liliac', 'Single stem', 'Purple'),
	(3, 3, 'Yellow Tulips - Sunny Prince', NULL, 'images/flower-example-tulip.jpg', 13, b'1', 'Tulip', 'Single stem', 'Yellow'),
	(4, 5, 'Red Perennial Tulips', NULL, 'images/flower-example-tulip-red-perennial.jpg', 7, b'1', 'Tulip', 'Single stem', 'Red'),
	(6, 2, 'Gorgeous \'Pink Giant\' Tulip', NULL, 'images/flower-example-tulip-pink.jpg', 9, b'1', 'Tulip', 'Single stem', 'Pink'),
	(7, 2, 'Lily-Flowered \'China Pink\' Tulip', NULL, 'images/flower-example-tulip-pink-china.jpg', 11, b'1', 'Tulip', 'Single stem', 'Pink'),
	(8, 2, 'Magestic Sunrise Dynasty Tulip', NULL, 'images/flower-example-tulip-sunrise.jpg', 10, b'1', 'Tulip', 'Single stem', 'Multicolor'),
	(9, 2, 'Tulip Triumph \'Tom Pouce\'', NULL, 'images/flower-example-tulip-tom-pouce.jpg', 8, b'1', 'Tulip', 'Single stem', 'Multicolor'),
	(10, 2, 'Elegant Purple Tulip', NULL, 'images/flower-example-tulip-purple.jpg', 9, b'1', 'Tulip', 'Single stem', 'Purple'),
	(11, 3, 'Purple Spanish Bluebells', NULL, 'images/flower-example-bluebell-purple.jpg', 5, b'1', 'Bluebell', 'Single stem', 'Purple'),
	(12, 4, 'Pretty Fresh Pink Tulips Bouquet', NULL, 'images/flower-example-tulip-pink-bouquet.jpg', 30, b'1', 'Tulip', 'Bouquet', 'Pink'),
	(13, 3, 'Stunning Bluebell', NULL, 'images/flower-example-bluebell-blue.jpg', 5, b'1', 'Bluebell', 'Single stem', 'Blue'),
	(14, 3, 'Forever Lasting Bluebell Bouquet', NULL, 'images/flower-example-bluebell-bouquet.jpg', 20, b'1', 'Bluebell', 'Bouquet', 'Purple'),
	(15, 6, 'Pink Lily of the Valley', NULL, 'images/flower-example-lily-of-the-valley-pink.jpg', 11, b'1', 'Lily of the Valley', 'Single stem', 'Pink'),
	(16, 5, 'Purple Bearded Iris', NULL, 'images/flower-example-iris-purple.jpg', 6, b'1', 'Iris', 'Single stem', 'Purple'),
	(17, 5, 'Rare Yellow Iris', NULL, 'images/flower-example-iris-yellow.jpg', 8, b'1', 'Iris', 'Single stem', 'Yellow'),
	(18, 5, 'Colorful Bearded Iris Mix', NULL, 'images/flower-example-iris-colorful.jpg', 30, b'1', 'Iris', 'Bouquet', 'Multicolor'),
	(19, 5, 'Blue Diamond Dutch Iris', NULL, 'images/flower-example-iris-blue.jpg', 8, b'1', 'Iris', 'Single stem', 'Multicolor'),
	(20, 3, 'Red Grace Peony', NULL, 'images/flower-example-peony-red.jpg', 10, b'1', 'Peony', 'Single stem', 'Red'),
	(21, 3, 'Yellow Itoh Peony', NULL, 'images/flower-example-peony-yellow.jpg', 10, b'1', 'Peony', 'Single stem', 'Yellow'),
	(22, 3, 'Gorgeous Pink Peony Bouquet', NULL, 'images/flower-example-peony-bouquet-pink.jpg', 25, b'1', 'Peony', 'Bouquet', 'Pink');

-- Dumping structure for table webgardening.reviews
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` double unsigned NOT NULL,
  `comment` longtext DEFAULT NULL,
  `created_on` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_reviews_user_id` (`user_id`),
  KEY `FK_reviews_prod_id` (`product_id`),
  CONSTRAINT `FK_reviews_prod_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_reviews_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.reviews: ~6 rows (approximately)
INSERT IGNORE INTO `reviews` (`id`, `user_id`, `product_id`, `rating`, `comment`, `created_on`) VALUES
	(1, 6, 1, 5, 'Great flower!', '2024-06-20 12:51:31'),
	(2, 6, 11, 4.5, 'Smells magnificent!', '2024-06-18 12:52:42'),
	(3, 6, 3, 5, 'Prettiest color!', '2024-06-12 12:53:08'),
	(4, 6, 8, 4.8, 'Truly magestic!', '2024-06-02 12:54:03'),
	(5, 6, 7, 5, 'Most beautiful tulips I have ever seen!', '2024-05-22 12:54:39'),
	(6, 4, 7, 4.5, 'I am impressed!', '2024-05-22 12:55:02');

-- Dumping structure for table webgardening.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.tags: ~10 rows (approximately)
INSERT IGNORE INTO `tags` (`id`, `name`) VALUES
	(1, 'Flower Photography'),
	(2, 'Marketing Tips'),
	(3, 'Soil Health'),
	(4, 'Gardening tips'),
	(5, 'Fertilizing'),
	(6, 'Plant Care'),
	(7, 'Tulips'),
	(8, 'Seeds'),
	(9, 'DIY'),
	(10, 'Digital Tools');

-- Dumping structure for table webgardening.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(512) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `pfp_url` varchar(150) NOT NULL DEFAULT 'images/default-pfp.jpg',
  `email_visibility` bit(1) DEFAULT NULL,
  `date_of_birth_visibility` bit(1) DEFAULT NULL,
  `address_visibility` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.users: ~6 rows (approximately)
INSERT IGNORE INTO `users` (`id`, `username`, `name`, `email`, `password_hash`, `date_of_birth`, `address`, `pfp_url`, `email_visibility`, `date_of_birth_visibility`, `address_visibility`) VALUES
	(1, 'admin', 'Web Gardening', 'admin@webgardening.example.com', '$2y$2y$10$m85uJjzXr7y1rCG7PtDuhuncwvfQ2x4oE.t0Qgmb6SSLEogthvEyK', NULL, NULL, 'images/default-pfp.jpg', NULL, NULL, NULL),
	(2, 'LucasGreenfield', 'Lucas Greenfield', 'lucas.greenfield@example.com', '$2y$10$3T31u7U9pRXEYxM2hzY3y.ZSt6BIEWZZggfJ5g0JhNWwiqpLb1e/S', NULL, NULL, 'images/default-pfp.jpg', NULL, NULL, NULL),
	(3, 'AnitaBloom', 'Anita Bloom', 'anita.bloom@example.com', '$2y$10$g2L8QO6cYLrRCAZwHg6pCuHDC81BvlsbVQnOne67GuHx9HGKGkE2K', NULL, NULL, 'images/default-pfp.jpg', NULL, NULL, NULL),
	(4, 'DandyLion', 'Dandy Lion', 'dandy.lion@example.com', '$2y$10$wRurNvd4EihEQH.Wc2BdY.EnD2kfyPMflIoRzVb4FllMS50Te5OTS', NULL, NULL, 'images/default-pfp.jpg', NULL, NULL, NULL),
	(5, 'EmilyThorn', 'Emily Thorn', 'emily.thorn@example.com', '$2y$10$hXgBDf2UoqapkgQR7C3Bv.CQUIATSM0dr2PMwkhnRB01QgOORaPW.', NULL, NULL, 'images/default-pfp.jpg', NULL, NULL, NULL),
	(6, 'EpicFace', 'Florea Florin-Cosmin', 'cosminflorin12@gmail.com', '$2y$10$gJf2wDareswXjWSgIvOqku9sxrtZM1P4xO2EDzqydslOACPp0Quxu', '1980-01-01', '123 Floral Street, Petal City', 'images/profile-picture.png', NULL, NULL, NULL);

-- Dumping structure for table webgardening.wishlist
CREATE TABLE IF NOT EXISTS `wishlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `added_on` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_wishlist_user_id` (`user_id`),
  KEY `FK_wishlist_prod_id` (`product_id`),
  CONSTRAINT `FK_wishlist_prod_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wishlist_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.wishlist: ~1 rows (approximately)
INSERT IGNORE INTO `wishlist` (`id`, `user_id`, `product_id`, `added_on`) VALUES
	(1, 6, 3, '2024-05-01');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
