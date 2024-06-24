-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.4.2-MariaDB - mariadb.org binary distribution
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
REPLACE INTO `blogs` (`id`, `title`, `content`, `image_url`, `author_id`, `date`, `description`) VALUES
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
REPLACE INTO `blogs_comments` (`id`, `blog_id`, `user_id`, `content`, `date`) VALUES
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
REPLACE INTO `blogs_likes` (`id`, `blog_id`, `user_id`) VALUES
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
REPLACE INTO `blogs_tags` (`blog_id`, `tag_id`) VALUES
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
REPLACE INTO `cart` (`id`, `user_id`, `product_id`, `quantity`, `added_on`) VALUES
	(1, 6, 1, 1, '2024-06-05'),
	(3, 6, 2, 1, '2024-06-24');

-- Dumping structure for table webgardening.gardens
CREATE TABLE IF NOT EXISTS `gardens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `created_on` date NOT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  `flower_type` varchar(50) DEFAULT NULL,
  `color_type` varchar(50) DEFAULT NULL,
  `is_shop` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gardens_user_id` (`user_id`),
  CONSTRAINT `FK_gardens_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.gardens: ~2 rows (approximately)
REPLACE INTO `gardens` (`id`, `user_id`, `username`, `name`, `created_on`, `longitude`, `latitude`, `description`, `image`, `flower_type`, `color_type`, `is_shop`) VALUES
	(1, 7, 'abc', 'test', '2024-06-24', 27.609, 47.1771, 'Here is the garden for my plantation of yellow tulips.', 'images/flower-example-tulip.jpg', 'tulip', 'yellow', b'0'),
	(2, 6, 'EpicFace', 'Cosmin', '2024-06-22', 45.5985, 23.2045, 'I havea humble plantation of blue bells', 'images/flower-example-bluebell-purple.jpg', 'blue bells', 'purple', b'0');

-- Dumping structure for table webgardening.inbox
CREATE TABLE IF NOT EXISTS `inbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` varchar(256) DEFAULT NULL,
  `timestamp` timestamp NOT NULL,
  `sender` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_inbox_user_id` (`user_id`),
  CONSTRAINT `FK_inbox_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.inbox: ~2 rows (approximately)
REPLACE INTO `inbox` (`id`, `user_id`, `type`, `timestamp`, `sender`) VALUES
	(1, 6, 'Interested in your blue bells', '2024-05-31 21:00:00', 'emily.thorn@example.com'),
	(2, 5, 'Interested in your blue bells', '2024-06-19 20:36:34', 'dandy.lion@example.com');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.orders: ~2 rows (approximately)
REPLACE INTO `orders` (`id`, `user_id`, `amount`, `status`, `date`) VALUES
	(1, 6, 10, 'delivered', '2024-06-24 19:37:30'),
	(2, 6, 3, 'shipped', '2024-06-22 15:42:45');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.orders_details: ~2 rows (approximately)
REPLACE INTO `orders_details` (`id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
	(1, 1, 3, 3, 39),
	(2, 2, 3, 1, 13);

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
REPLACE INTO `products` (`id`, `seller_id`, `name`, `description`, `image_url`, `price`, `available`, `type`, `category`, `color`) VALUES
	(1, 3, 'Beautiful Light Pink Peonies', 'Elegant and delicate, our Beautiful Light Pink Peonies exude timeless charm. With their soft petals and enchanting fragrance, these peonies are perfect for adding a touch of grace to any bouquet or garden.', 'images/flower-example.jpg', 10, b'1', 'Peony', 'Single stem', 'Pink'),
	(2, 3, 'Blooming Lilac', 'Experience the enchanting beauty of our Blooming Lilac. Known for its prolific clusters of fragrant purple blossoms, this perennial shrub thrives in sunny locations with well-drained soil. Ideal for creating stunning garden borders or cut-flower arrangements, our lilacs bloom in late spring to early summer, attracting butterflies and filling the air with their delightful aroma. Add a touch of elegance and natural charm to your outdoor spaces with these resilient and captivating blooms.', 'images/flower-example-lilac.jpg', 8, b'1', 'Liliac', 'Single stem', 'Purple'),
	(3, 3, 'Yellow Tulips - Sunny Prince', 'Introducing our Yellow Tulips - Sunny Prince, a regal addition to any garden or floral display. These vibrant yellow tulips boast sturdy stems and a cheerful disposition, blooming in early spring to brighten up your landscape. With their classic cup-shaped blooms and robust growth, Sunny Prince tulips are perfect for borders, containers, or indoor arrangements. Bring a splash of sunshine to your surroundings with these captivating and resilient flowers.', 'images/flower-example-tulip.jpg', 13, b'1', 'Tulip', 'Single stem', 'Yellow'),
	(4, 5, 'Red Perennial Tulips', 'Our Red Perennial Tulips offer timeless beauty year after year. With bold, red blooms that stand tall on sturdy stems, these tulips are perfect for adding vibrant color to gardens and bouquets alike. Enjoy their enduring charm and effortless elegance season after season.', 'images/flower-example-tulip-red-perennial.jpg', 7, b'1', 'Tulip', 'Single stem', 'Red'),
	(6, 2, 'Gorgeous \'Pink Giant\' Tulip', 'Behold the allure of our Gorgeous \'Pink Giant\' Tulip, a showstopper in any garden. Featuring large, soft pink blooms with a hint of apricot, these tulips create a stunning focal point. Their robust stems and long-lasting flowers make them ideal for creating impressive floral arrangements or enhancing borders with their captivating presence.', 'images/flower-example-tulip-pink.jpg', 9, b'1', 'Tulip', 'Single stem', 'Pink'),
	(7, 2, 'Lily-Flowered \'China Pink\' Tulip', 'Delicate and graceful, our Lily-Flowered \'China Pink\' Tulip adds an elegant touch to gardens and landscapes. With slender, pointed petals that resemble lilies, these tulips bloom in soft shades of pink with a subtle white base. Their unique form and pastel hues make them a charming choice for beds, borders, and cut-flower arrangements.', 'images/flower-example-tulip-pink-china.jpg', 11, b'1', 'Tulip', 'Single stem', 'Pink'),
	(8, 2, 'Magestic Sunrise Dynasty Tulip', 'Experience the grandeur of our Majestic Sunrise Dynasty Tulip, a true spectacle of nature. With large, vibrant blooms in shades of sunrise hues—soft oranges, pinks, and yellows—these tulips command attention in any setting. Plant them in clusters for a breathtaking display that heralds the arrival of spring.', 'images/flower-example-tulip-sunrise.jpg', 10, b'1', 'Tulip', 'Single stem', 'Multicolor'),
	(9, 2, 'Tulip Triumph \'Tom Pouce\'', 'Meet Tulip Triumph \'Tom Pouce\', a compact variety with a big impact. These charming tulips feature rosy pink petals that open wide to reveal a sunny yellow center. Known for their sturdy stems and long-lasting flowers, \'Tom Pouce\' tulips are perfect for borders, containers, or cutting for bouquets, adding a touch of cheerful elegance to your garden.', 'images/flower-example-tulip-tom-pouce.jpg', 8, b'1', 'Tulip', 'Single stem', 'Multicolor'),
	(10, 2, 'Elegant Purple Tulip', 'Indulge in the sophistication of our Elegant Purple Tulip, a symbol of grace and beauty. With deep, velvety purple petals that exude richness, these tulips create a striking contrast against green foliage. Plant them in clusters or mix with other spring flowers to create a captivating display that evokes a sense of tranquility and refinement.', 'images/flower-example-tulip-purple.jpg', 9, b'1', 'Tulip', 'Single stem', 'Purple'),
	(11, 3, 'Purple Spanish Bluebells', 'Discover the enchanting allure of our Purple Spanish Bluebells. Adorned with bell-shaped blooms in shades of purple and violet, these perennial flowers bring a touch of woodland charm to gardens and borders. Easy to grow and versatile in various soil conditions, Spanish Bluebells thrive in both sun and partial shade, adding elegance and color to any landscape.', 'images/flower-example-bluebell-purple.jpg', 5, b'1', 'Bluebell', 'Single stem', 'Purple'),
	(12, 4, 'Pretty Fresh Pink Tulips Bouquet', 'Celebrate the season with our Pretty Fresh Pink Tulips Bouquet, a delightful arrangement that captures the essence of spring. Featuring soft pink tulips in full bloom, accented with lush green foliage, this bouquet radiates beauty and freshness. Perfect for gifting or brightening up your home, these tulips bring joy and a touch of natural elegance to any occasion.', 'images/flower-example-tulip-pink-bouquet.jpg', 30, b'1', 'Tulip', 'Bouquet', 'Pink'),
	(13, 3, 'Stunning Bluebell', 'Immerse yourself in the beauty of our Stunning Bluebell, a symbol of spring\'s arrival. Adorned with vibrant blue blossoms that sway gracefully on slender stems, these woodland flowers add a splash of color to shady garden spots. Plant them in clusters for a mesmerizing display that attracts pollinators and captivates onlookers with its natural charm.', 'images/flower-example-bluebell-blue.jpg', 5, b'1', 'Bluebell', 'Single stem', 'Blue'),
	(14, 3, 'Forever Lasting Bluebell Bouquet', 'Embrace everlasting beauty with our Forever Lasting Bluebell Bouquet in shades of purple. Handcrafted to preserve the delicate allure of fresh blooms, this bouquet features purple bluebells that retain their vibrant color and graceful form over time. Perfect for special occasions or as a lasting centerpiece, these flowers bring enduring elegance to any setting.', 'images/flower-example-bluebell-bouquet.jpg', 20, b'1', 'Bluebell', 'Bouquet', 'Purple'),
	(15, 6, 'Pink Lily of the Valley', 'Delicate and enchanting, our Pink Lily of the Valley adds a touch of fairy-tale charm to any garden. Featuring dainty, bell-shaped blooms in soft pink hues, these fragrant flowers bloom in early spring, creating a carpet of beauty beneath shady trees or along garden paths. Ideal for woodland gardens or as ground cover, Lily of the Valley brings timeless elegance and sweet fragrance to outdoor spaces.', 'images/flower-example-lily-of-the-valley-pink.jpg', 11, b'1', 'Lily of the Valley', 'Single stem', 'Pink'),
	(16, 5, 'Purple Bearded Iris', 'Experience the majestic allure of our Purple Bearded Iris, a symbol of grace and refinement. With large, ruffled blooms in shades of royal purple, these iris flowers stand tall on sturdy stems, making them perfect for borders or cutting gardens. Plant them in sunny locations with well-drained soil to enjoy their stunning blooms in late spring to early summer.', 'images/flower-example-iris-purple.jpg', 6, b'1', 'Iris', 'Single stem', 'Purple'),
	(17, 5, 'Rare Yellow Iris', 'Capture the essence of rarity with our Rare Yellow Iris, a treasure in any garden. Featuring striking yellow blooms with intricate patterns and delicate ruffles, these iris flowers bring a splash of sunshine to your landscape. Plant them as focal points or mix them with other perennials for a vibrant and eye-catching display.', 'images/flower-example-iris-yellow.jpg', 8, b'1', 'Iris', 'Single stem', 'Yellow'),
	(18, 5, 'Colorful Bearded Iris Mix', 'Celebrate diversity and beauty with our Colorful Bearded Iris Mix, a dazzling bouquet of iris flowers in a variety of enchanting hues. From deep purples and blues to soft pinks and whites, each bloom in this mix boasts distinctive patterns and velvety petals. Perfect for creating stunning floral arrangements or adding a burst of color to garden borders, this mix captivates with its rich diversity and floral charm.', 'images/flower-example-iris-colorful.jpg', 30, b'1', 'Iris', 'Bouquet', 'Multicolor'),
	(19, 5, 'Blue Diamond Dutch Iris', 'Embrace the allure of our Blue Diamond Dutch Iris, a kaleidoscope of colors in a single bloom. With petals showcasing shades of blue, purple, and white, each flower is a masterpiece of natural artistry. Plant these Dutch iris bulbs in clusters for a captivating display that enhances gardens and bouquets alike with their striking beauty and elegant form.', 'images/flower-example-iris-blue.jpg', 8, b'1', 'Iris', 'Single stem', 'Multicolor'),
	(20, 3, 'Red Grace Peony', 'Discover the timeless elegance of our Red Grace Peony, a symbol of romance and luxury. With large, double blooms in rich shades of deep red, these peonies exude opulence and grace. Plant them in well-drained soil and enjoy their lush foliage and stunning flowers throughout the spring season. Perfect for bouquets or as focal points in garden beds, Red Grace Peony adds a touch of regal beauty to any setting.', 'images/flower-example-peony-red.jpg', 10, b'1', 'Peony', 'Single stem', 'Red'),
	(21, 3, 'Yellow Itoh Peony', 'Bask in the sunshine hues of our Yellow Itoh Peony, a blend of charm and resilience. Combining the best qualities of herbaceous and tree peonies, these yellow blooms offer a longer blooming period and sturdy stems. With their cheerful color and captivating fragrance, Itoh peonies are perfect for adding warmth and elegance to garden borders or as cut flowers in bouquets.', 'images/flower-example-peony-yellow.jpg', 10, b'1', 'Peony', 'Single stem', 'Yellow'),
	(22, 3, 'Gorgeous Pink Peony Bouquet', 'Indulge in the splendor of our Gorgeous Pink Peony Bouquet, a masterpiece of nature\'s beauty. Featuring lush, pink peonies in full bloom, accented with verdant foliage, this bouquet is a celebration of elegance and romance. Whether as a gift or a centerpiece, these peonies captivate with their abundant petals and captivating fragrance, bringing joy and sophistication to any occasion.', 'images/flower-example-peony-bouquet-pink.jpg', 25, b'1', 'Peony', 'Bouquet', 'Pink');

-- Dumping structure for table webgardening.reviews
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
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
REPLACE INTO `reviews` (`id`, `user_id`, `product_id`, `username`, `rating`, `comment`, `created_on`) VALUES
	(1, 6, 1, 'EpicFace', 5, 'Great flower!', '2024-06-20 12:51:31'),
	(2, 6, 11, 'EpicFace', 4.5, 'Smells magnificent!', '2024-06-18 12:52:42'),
	(3, 6, 3, 'EpicFace', 5, 'Prettiest color!', '2024-06-12 12:53:08'),
	(4, 6, 8, 'EpicFace', 4.8, 'Truly magestic!', '2024-06-02 12:54:03'),
	(5, 6, 7, 'EpicFace', 5, 'Most beautiful tulips I have ever seen!', '2024-05-22 12:54:39'),
	(6, 4, 7, 'Dandy Lion', 4.5, 'I am impressed!', '2024-05-22 12:55:02');

-- Dumping structure for table webgardening.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.tags: ~10 rows (approximately)
REPLACE INTO `tags` (`id`, `name`) VALUES
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
  `description` longtext DEFAULT 'Flower enthusiast.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table webgardening.users: ~7 rows (approximately)
REPLACE INTO `users` (`id`, `username`, `name`, `email`, `password_hash`, `date_of_birth`, `address`, `pfp_url`, `email_visibility`, `date_of_birth_visibility`, `address_visibility`, `description`) VALUES
	(1, 'admin', 'Web Gardening', 'admin@webgardening.example.com', '24a7c19a9dae9eeedae5c44c2015a00d8dc74962b9ed2e658a8d959c96b1b9af2a2cacb301e749d936ae7612df9b95c159ec054d43c75e65eca5f8860e5b99de7149e4848ab599727f8f3f51fb1caca8', '1999-06-23', 'Web Gardening Headquarters', 'images/default-pfp.jpg', b'1', b'1', b'1', 'Admin.'),
	(2, 'LucasGreenfield', 'Lucas Greenfield', 'lucas.greenfield@example.com', '24a7c19a9dae9eeedae5c44c2015a00d8dc74962b9ed2e658a8d959c96b1b9af2a2cacb301e749d936ae7612df9b95c159ec054d43c75e65eca5f8860e5b99de7149e4848ab599727f8f3f51fb1caca8', '1987-05-23', '456 Blossom Avenue, Bloomville\n', 'images/default-pfp.jpg', b'1', b'1', b'1', 'As an avid gardener turned entrepreneur, I\'m committed to offering the finest blooms through our flower-selling platform. Every flower we grow and sell is nurtured with meticulous care, ensuring premium quality and freshness. Join us in celebrating the beauty of nature\'s bounty, one exquisite bloom at a time.'),
	(3, 'AnitaBloom', 'Anita Bloom', 'anita.bloom@example.com', '24a7c19a9dae9eeedae5c44c2015a00d8dc74962b9ed2e658a8d959c96b1b9af2a2cacb301e749d936ae7612df9b95c159ec054d43c75e65eca5f8860e5b99de7149e4848ab599727f8f3f51fb1caca8', '2000-02-20', '246 Orchid Road, Tulip Town\n', 'images/default-pfp.jpg', b'1', b'1', b'1', 'I\'m fascinated by the diverse world of flowers and the stories they tell through their unique hues and scents. Our platform offers a curated selection of premium blooms, sourced to perfection. Whether you\'re looking to brighten your day or seeking the ideal gift, discover how our passion for flowers elevates every moment.'),
	(4, 'DandyLion', 'Dandy Lion', 'dandy.lion@example.com', '24a7c19a9dae9eeedae5c44c2015a00d8dc74962b9ed2e658a8d959c96b1b9af2a2cacb301e749d936ae7612df9b95c159ec054d43c75e65eca5f8860e5b99de7149e4848ab599727f8f3f51fb1caca8', '1992-10-10', '789 Garden Lane, Roseville\n', 'images/default-pfp.jpg', b'1', b'1', b'1', 'Driven by a deep love for flowers, I devote myself to cultivating and selling these natural marvels. Each bloom reflects my commitment to nurturing beauty and spreading joy through nature\'s finest creations. Discover the essence of floral elegance and bring a touch of natural splendor into your life.'),
	(5, 'EmilyThorn', 'Emily Thorn', 'emily.thorn@example.com', '24a7c19a9dae9eeedae5c44c2015a00d8dc74962b9ed2e658a8d959c96b1b9af2a2cacb301e749d936ae7612df9b95c159ec054d43c75e65eca5f8860e5b99de7149e4848ab599727f8f3f51fb1caca8', '2003-12-04', '777 Sunflower Boulevard, Magnolia Meadows\n\n\n\n\n\n', 'images/default-pfp.jpg', b'1', b'1', b'1', 'I believe in the transformative power of flowers to elevate any moment. By meticulously growing and selecting each bloom, I ensure that our offerings exceed expectations in both beauty and quality. Join me in celebrating nature\'s finest with flowers that embody elegance, freshness, and the joy they bring.'),
	(6, 'EpicFace', 'Florea Florin-Cosmin', 'cosminflorin12@gmail.com', '24a7c19a9dae9eeedae5c44c2015a00d8dc74962b9ed2e658a8d959c96b1b9af2a2cacb301e749d936ae7612df9b95c159ec054d43c75e65eca5f8860e5b99de7149e4848ab599727f8f3f51fb1caca8', '1980-01-01', '123 Floral Street, Petal City', 'images/profile-picture.png', b'1', b'1', b'1', 'I\'m passionate about flowers and their beauty, which is why I\'ve dedicated myself to cultivating and sharing these wonders through our flower-selling platform. With a deep love for nature\'s colors and fragrances, I strive to bring the joy of fresh blooms into every home. Join me in exploring a world where every petal tells a story of growth, care, and the simple joys of nature.'),
	(7, 'abc', 'test', 'a@b.c', '24a7c19a9dae9eeedae5c44c2015a00d8dc74962b9ed2e658a8d959c96b1b9af2a2cacb301e749d936ae7612df9b95c159ec054d43c75e65eca5f8860e5b99de7149e4848ab599727f8f3f51fb1caca8', '2024-06-23', 'In my imagination', 'images/default-pfp.jpg', b'1', b'1', b'1', 'Flower enthusiast.');

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
REPLACE INTO `wishlist` (`id`, `user_id`, `product_id`, `added_on`) VALUES
	(1, 6, 3, '2024-05-01');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
