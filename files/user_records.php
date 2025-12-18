<?php
// --- PART 1: PHP Indexed Array ---
$userIndexed = array(
    201,
    "Alex Reyes",
    "alex@example.com",
    "User"
);

echo "INDEXED ARRAY USER\n";
echo "User ID: " . $userIndexed[0] . "\n";
echo "Name: " . $userIndexed[1] . "\n";
echo "Email: " . $userIndexed[2] . "\n";
echo "Role: " . $userIndexed[3] . "\n\n";


// --- PART 2: PHP Associative Array ---
$userAssoc = array(
    "user_id" => 202,
    "name" => "Bianca Cruz",
    "email" => "bianca@example.com",
    "role" => "Admin"
);

echo "ASSOCIATIVE ARRAY USER\n";
echo "User ID: " . $userAssoc["user_id"] . "\n";
echo "Name: " . $userAssoc["name"] . "\n";
echo "Email: " . $userAssoc["email"] . "\n";
echo "Role: " . $userAssoc["role"] . "\n";
?>
