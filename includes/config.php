<?php

const DBNAME = "student_passwords";
const DBHOST = "localhost";
const DBUSER = "passwords_user";
const KEYSTR = "UNHEX(SHA2('hubbabubba', 512))";
const INITVECTOR = "RANDOM_BYTES(16)";
