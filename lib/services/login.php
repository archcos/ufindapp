<?php
header('Content-Type: application/json');
$conn = new mysqli('localhost', 'root', '', 'ufinddb');

if ($conn->connect_error) {
    die(json_encode(['success' => false, 'message' => 'Database connection failed']));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $username = $conn->real_escape_string($data['user_email']);
    $password = sha1($conn->real_escape_string($data['hashed_password'])); // Hash the input password with SHA-1

    $query = "SELECT * FROM tbluser WHERE user_email='$user_email' AND hashed_password='$hashed_password'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        echo json_encode(['success' => true, 'message' => 'Login successful']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid credentials']);
    }
}

$conn->close();
?>
