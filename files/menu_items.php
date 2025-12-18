<?php
// --- PART 1: INDEXED ARRAY ---
$menuNames = [
    "Chicken Adobo",
    "Pork Sinigang",
    "Halo-Halo"
];

echo "INDEXED ARRAY\n";
echo "Item 1: " . $menuNames[0] . "\n";
echo "Item 2: " . $menuNames[1] . "\n";
echo "Item 3: " . $menuNames[2] . "\n\n";


// --- PART 2: ASSOCIATIVE ARRAY ---
$menuItem = [
    "menu_id" => 1,
    "menu_name" => "Chicken Adobo",
    "category" => "Main Dish",
    "price" => 150.00,
    "availability" => true
];

echo "ASSOCIATIVE ARRAY\n";
echo "Menu ID: " . $menuItem["menu_id"] . "\n";
echo "Name: " . $menuItem["menu_name"] . "\n";
echo "Category: " . $menuItem["category"] . "\n";
echo "Price: P" . $menuItem["price"] . "\n";
// Uses a ternary operator to print "Yes" if true, "No" if false
echo "Available: " . ($menuItem["availability"] ? "Yes" : "No") . "\n";
?>
