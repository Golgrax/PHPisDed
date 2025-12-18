<?php
// PRODUCT LIST EXAMPLE

// Associative array definition (from Slide 6)
$products = array(
    "Dress" => 1200,
    "Shoes" => 2500
);

echo "--- PRODUCT LIST ---
";

// Loop through the array to display key (Product) and value (Price)
foreach ($products as $productName => $price) {
    echo "Product: " . $productName . " | Price: " . $price . "\n";
}
?>
