//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Library {

   struct Book {
      uint id;
      bytes32 bookName;
      bytes32 author;
      uint yearOfPublishment;
      bool available;
   }

   Book[] public bookList;
   mapping (address => uint[]) ownersOfBooks;

   function addBook(bytes32 bookName, bytes32 author, uint yearOfPublishment) external {
      bookList.push(Book(bookList.length, bookName, author, yearOfPublishment, true));
   }

   // Check if the requested book is available, by not being read by someone else, if so -> add it to the list of owner's list of books
   function getBook(bytes32 _bookName, bytes32 _author) external {
      for(uint i; i < bookList.length; i++) {
         if(bookList[i].bookName == _bookName && bookList[i].author == _author) {
            bookList[i].available = false;
            ownersOfBooks[msg.sender].push(bookList[i].id);
         }
      }
   }
}