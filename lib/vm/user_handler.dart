// /* description : 회원정보 저장을 위한 DB 
//  * date : 2024.11.28
//  * author : snr
//  * update : 
//  *  - 2024.11.28 : 회원정보 저장을 위한 DB 생성
//  */

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class UserHandler {

//   // Table 생성
//   Future<Database> initializeDB() async {
//     String path = await getDatabasesPath(); 
//     return openDatabase(
//       join(path, 'user.db'),   
      
//       onCreate: (db, version) async {
//         await db.execute(
//           'create table user (id text primary key, name text, telno text, password text, status integer )'
//         );
//       },
//       version: 1,
//     );
//   }

//   //id, pw select영역
//   // return 1 : 로그인 성공
//   // return 2 : 회원정보 없음 
//   // return 3 : 로그인 실패
//   Future<int> selectUser(String id, String pw) async {
//     final Database db = await initializeDB();
    
//     final List<Map<String, dynamic>> result = await db.rawQuery("SELECT COUNT(*) FROM user WHERE id = ? AND password = ?", [id, pw]);
//     int count = Sqflite.firstIntValue(result) ?? 0;

//     print("count : \(count)");
//     if (count  > 0) {
//       //로그인 성공
//       return 1;
//     } else {
//       //id 값이 있는지 확인
//       final List<Map<String, dynamic>> idCheck = await db.rawQuery("SELECT COUNT(*) FROM user WHERE password = ?", [id]);
//       int idResult = Sqflite.firstIntValue(idCheck) ?? 0 ;
//       print("idResult : \(idResult)");

//       return idResult > 0 ? 3 : 2;
//     }
//   }

//   // id 찾기
//   Future<String?> findUserId(String name, String telno) async {
//     final Database db = await initializeDB();
//     final List<Map<String, dynamic>> result = await db.rawQuery("SELECT id FROM user WHERE name = ? AND  telno = ?", [name, telno]);
//     if (result.isNotEmpty) {
//       return result.first['id'] as String?;
//     } else {
//       return null;
//     }
//   }



// //  int? idValue;
// //     String name;
// //     String id;
// //     String password;
// //     int status;
// }