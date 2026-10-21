import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';

const List<QuizCategory> quizCategories = [
  QuizCategory(
    id: 'programming',
    title: 'Programming',
    description: 'Dasar-dasar pemrograman dan teknologi.',
    icon: Icons.code_rounded,
    questions: [
      Question('Bahasa pemrograman yang digunakan Flutter adalah...',
          ['Java', 'Dart', 'Kotlin', 'Swift'], 1),
      Question('HTML adalah singkatan dari...', [
        'HyperText Markup Language',
        'High Tech Modern Language',
        'HyperTool Multi Language',
        'Home Text Markup Level'
      ], 0),
      Question('Struktur data dengan prinsip LIFO adalah...',
          ['Queue', 'Array', 'Stack', 'Tree'], 2),
      Question('Penanda komentar satu baris di Dart adalah...',
          ['#', '//', '--', '/*'], 1),
      Question('Kompleksitas waktu binary search adalah...',
          ['O(n)', 'O(n²)', 'O(1)', 'O(log n)'], 3),
    ],
  ),


  QuizCategory(
  id: 'olahraga',
  title: 'Olahraga',
  description: 'Sepak bola, bulu tangkis, dan olahraga dunia.',
  icon: Icons.sports_soccer_rounded,
  questions: [
    Question('Berapa jumlah pemain inti satu tim sepak bola di lapangan?',
        ['9', '10', '11', '12'], 2),
    Question('Dalam bulu tangkis, alat yang dipukul disebut...',
        ['Bola', 'Kok', 'Puck', 'Cakram'], 1),
    Question('Olahraga basket dimainkan dengan tujuan...',
        ['Memasukkan bola ke ring', 'Menendang bola ke gawang',
         'Memukul bola melewati net', 'Melempar cakram'], 0),
    Question('Berapa jumlah cincin pada simbol Olimpiade?',
        ['4', '5', '6', '7'], 1),
    Question('Olahraga yang menggunakan istilah checkmate adalah...',
        ['Catur', 'Tenis', 'Golf', 'Tinju'], 0),

         Question('Olahraga yang memerlukan kontak fisik adalah..',
        ['Tenis', 'Golf','Catur', 'Tinju'], 3),
  ],
),

  
  QuizCategory(
    id: 'sains',
    title: 'Sains',
    description: 'Fisika, kimia, dan biologi dasar.',
    icon: Icons.science_rounded,
    questions: [
      Question('Planet terbesar di tata surya adalah...',
          ['Saturnus', 'Bumi', 'Jupiter', 'Neptunus'], 2),
      Question('Rumus kimia air adalah...', ['CO2', 'H2O', 'O2', 'NaCl'], 1),
      Question('Gas terbanyak di atmosfer Bumi adalah...',
          ['Oksigen', 'Nitrogen', 'Karbon dioksida', 'Argon'], 1),
      Question('Satuan gaya dalam SI adalah...',
          ['Joule', 'Watt', 'Pascal', 'Newton'], 3),
      Question('Organ yang memompa darah ke seluruh tubuh adalah...',
          ['Paru-paru', 'Hati', 'Jantung', 'Ginjal'], 2),
    ],
  ),
  QuizCategory(
    id: 'general',
    title: 'General Knowledge',
    description: 'Wawasan umum seputar dunia dan Indonesia.',
    icon: Icons.public_rounded,
    questions: [
      Question('Indonesia memproklamasikan kemerdekaan pada tahun...',
          ['1942', '1945', '1950', '1955'], 1),
      Question('Samudra terluas di dunia adalah...',
          ['Atlantik', 'Hindia', 'Pasifik', 'Arktik'], 2),
      Question('Lambang negara Indonesia adalah...',
          ['Garuda Pancasila', 'Harimau', 'Banteng', 'Elang Jawa'], 0),
      Question('Benua terbesar di dunia adalah...',
          ['Afrika', 'Asia', 'Eropa', 'Amerika'], 1),
      Question('Pencipta lagu "Indonesia Raya" adalah...', [
        'Ismail Marzuki',
        'C. Simanjuntak',
        'W.R. Supratman',
        'H. Mutahar'
      ], 2),
    ],
  ),
];
