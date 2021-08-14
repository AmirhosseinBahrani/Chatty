
var bcrypt = require('bcrypt');
var SALT_WORK_FACTOR = 12;
var MongoClient = require('mongodb').MongoClient;
const { Mongoose } = require("mongoose");
require("dotenv/config");
var app = require('express')();
var http = require('http').createServer(app); // here maybe Serve(app)
var io = require('socket.io')(http);
var MD5 = require("md5");
var Crypto = require("crypto");
var sha256 = require("sha256");
var cookieParser = require('cookie-parser');
var RNCrypter = require("rncryptor-js");
const CryptoJS = require('crypto-js');
const uuid = require('uuid');
const AesA = require('js-crypto-aes');
const converter = require('base64-arraybuffer');
var SHA512 = require("crypto-js/sha512");
var cookie = require("cookies");



//app.use(cookieParser());
//const session = require("express-session")({
//    secret: "my-secret",
//    resave: true,
//    saveUninitialized: true,
//    cookie:{
//        maxAge: 6000000
//    }
//});
//var sharedsession = require("express-socket.io-session");
//jfkjdsirueiwocf231748874389fjjiewaofjdsufheawfsce3246
//app.use(session);
//io.use(sharedsession(session));
//app.use(session({
//    secret :  'secret', // Related to session id cookie for signing
//    name: "cookie_name",
//    proxy: true,
//    resave: true,
//    saveUninitialized: true,
//    maxAge: 3600000   
//}));

//io.use(sharedsession(session, {
    //secret: 'codingdefined',
    //resave: true,
   // saveUninitialized: true
//})); 

//const wrap = middleware => (socket, next) => middleware(socket.request, {}, next);
//io.use(wrap(session({ secret: "jfkjdsirueiwocf231748874389fjjiewaofjdsufheawfsce3246" })));
function GRandom(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * 
 charactersLength));
   }
   return result;
}
io.use(function(socket, next) {
    const key = new TextEncoder().encode("A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp"); // 16 bytes or 32 bytes key in Uint8Array
    const iv = new TextEncoder().encode("P3M8G;*s@sbG{(-a"); // 16 bytes IV in Uint8Array for AES-CBC mode
    const EncryptedBI = new Uint8Array(converter.decode(socket.handshake.query.BI));
    const EncryptedUD = new Uint8Array(converter.decode(socket.handshake.query.UD));
    const EncryptedPrivateToken = new Uint8Array(converter.decode(socket.handshake.query.Token));

    AesA.decrypt(EncryptedBI, key, {name: 'AES-CBC', iv}).then( (DecodedBI) => {
        
        let DecodedBIstr = Buffer.from(DecodedBI).toString('base64');
        const buff1 = Buffer.from(DecodedBIstr, 'base64');
        const BIPlainText = buff1.toString('utf-8');

        AesA.decrypt(EncryptedUD, key, {name: 'AES-CBC', iv}).then( (DecodedUD) => {
            let DecodedUDstr = Buffer.from(DecodedUD).toString('base64');
            const buff2 = Buffer.from(DecodedUDstr, 'base64');
            const UDPlainText = buff2.toString('utf-8');

            AesA.decrypt(EncryptedPrivateToken, key, {name: 'AES-CBC', iv}).then( (DecodedPrivateToken) => {
                let DecodedPrivateTokenstr = Buffer.from(DecodedPrivateToken).toString('base64');
                const buff3 = Buffer.from(DecodedPrivateTokenstr, 'base64');
                const PrivateTokenPlainText = buff3.toString('utf-8');

                const EncryptedDecryptedPrivateToken = new Uint8Array(converter.decode(PrivateTokenPlainText));

                AesA.decrypt(EncryptedDecryptedPrivateToken, key, {name: 'AES-CBC', iv}).then( (DecryptedDecryptedPrivateToken) => {

                    let DecodedDecodedPrivateTokenstr = Buffer.from(DecryptedDecryptedPrivateToken).toString('base64');
                    const buff4 = Buffer.from(DecodedDecodedPrivateTokenstr, 'base64');
                    const PrivateTokenPlainText = buff4.toString('utf-8');

                    console.log(PrivateTokenPlainText);
                    if (sha256(BIPlainText + UDPlainText + process.env.secret) == PrivateTokenPlainText){
                        console.log("Connection Accepted");
                        next(null, true);
                    }
                    else{
                        next("Connecting Error", false)
                    }
                });
            });
        });
    }); 
})


var Status;
var ConnectionNumber;   


MongoClient.connect("mongodb://127.0.0.1:27017",function(err, db) {
    if (err){
        return err;
    }
    else{
        console.log("Connected to Db");
        io.on("connection",async function(socket) {
            console.log("sa");
            
            var UserKeysFromQuesry = socket.handshake.query.Keys.replace('Optional','').replace("(", "").replace(")","").replace('[','').replace(']','').replace('"','').replace('"','').replace('"','').replace('"','').replace('"','').replace('"','').replace('"','').replace('"','').split(',').map(x => x.trim());

            

            if (UserKeysFromQuesry == "nil"){
                console.log("no");
                socket.emit("Status","NotLoggedIn")
                Status = "NotLoggedIn"
            }
            else{
                var encryptedUserDataFromDatabase = await db.db("users").collection("users").findOne({UserLoginToken: socket.handshake.query.LT});
                var encryptedUserLoginTokenBase64 = new Uint8Array(converter.decode(encryptedUserDataFromDatabase.Sessions[0]));
                var encryptedIsLoggedInBase64 = new Uint8Array(converter.decode(encryptedUserDataFromDatabase.Sessions[1]));
                console.log(UserKeysFromQuesry);
                var key = new TextEncoder().encode(UserKeysFromQuesry[0])
                var iv = new TextEncoder().encode(UserKeysFromQuesry[1]) 
                console.log(encryptedUserDataFromDatabase.Sessions);
                AesA.decrypt(encryptedUserLoginTokenBase64, key, {name: "AES-CBC", iv}).then((E) => {
                    let Base64String1 = Buffer.from(E).toString('base64');
                    const buffer3 = Buffer.from(Base64String1, 'base64');
                    const PT1 = buffer3.toString('utf-8');
                    console.log("helllo");

                    key = new TextEncoder().encode(UserKeysFromQuesry[2])
                    iv = new TextEncoder().encode(UserKeysFromQuesry[3])
                    AesA.decrypt(encryptedIsLoggedInBase64, key, {name: "AES-CBC",iv}).then((E2) => {
                        let Base64String2 = Buffer.from(E2).toString('base64');
                        const buffer4 = Buffer.from(Base64String2, 'base64');
                        const PT2 = buffer4.toString('utf-8');
                        console.log(PT1, PT2);
                        if (PT1 == socket.handshake.query.LT && PT2 == "true"){
                            socket.emit("Status", "AlreadyLoggedIn");
                            Status = "AlreadyLoggedIn"
                        }
                        else{
                            socket.emit("Status", "NotLoggedIn");
                            Status = "NotLoggedIn"
                        }
                        
                    });
                }).catch((err) => {
                    console.log(err);
                })
            }

            socket.on("Login",async function(username,password,callback) {
                if (Status == "NotLoggedIn" && socket.handshake.query.LT == "NotCreated"){
                    var UsersAllCollections = db.db("users").collection("users");
                    await bcrypt.genSalt(SALT_WORK_FACTOR,async function(err, salt) {
                        if (err){
                            callback("ErrorInLogin");
                        } 
                        await UsersAllCollections.findOne({username: username}, function(err, user){
                            if (err){
                                callback("ErrorInLogin");
                            }
                            if (!user){
                                callback("ErrorInLogin");
                            }
                            bcrypt.compare(password, user.password, function(err, isMatch) {
                                if (err){
                                    callback("ErrorInLogin");
                                }
                                else{
                                    if (isMatch && isMatch == true){
                                        let date_ob = new Date();
                                        var UserLoginToken = MD5((username) + SHA512(MD5(password) + MD5(username + password)));
                                        console.log(UserLoginToken,"UserLoginToken");
                                            var SessionKey1 = GRandom(32)
                                            var SessionIv1 = GRandom(16)

                                            const UserLoginTokenUint8Array = new TextEncoder().encode(UserLoginToken); // arbitrary length of message in Uint8Array
                                            const SessionKey1Uint8Array = new TextEncoder().encode(SessionKey1); // 16 bytes or 32 bytes key in Uint8Array
                                            const SessionIv1Uint8Array = new TextEncoder().encode(SessionIv1); // 16 bytes IV in Uint8Array for AES-CBC mode

                                            var SessionKey2 = GRandom(32)
                                            var SessionIv2 = GRandom(16)
                                            console.log("here2");
                                            const IsLoggedInUint8Array = new TextEncoder().encode("true"); // arbitrary length of message in Uint8Array
                                            const SessionKey2Uint8Array = new TextEncoder().encode(SessionKey2); // 16 bytes or 32 bytes key in Uint8Array
                                            const SessionIv2Uint8Array = new TextEncoder().encode(SessionIv2); // 16 bytes IV in Uint8Array for AES-CBC mode
                                            console.log("here3");
                                            AesA.encrypt(UserLoginTokenUint8Array,SessionKey1Uint8Array,{name: 'AES-CBC',iv: SessionIv1Uint8Array}).then((EncryptedUserLoginTokenUint8Array) => {
                                                let Base64ULT = Buffer.from(EncryptedUserLoginTokenUint8Array).toString('base64');
                                                console.log("here4");

                                                let EncryptedUserLoginTokenBase64Encoded = new TextEncoder().encode(Base64ULT);
                                                var EncryptedUserLoginToken = Buffer.from(EncryptedUserLoginTokenBase64Encoded).toString('utf8')

                                                AesA.encrypt(IsLoggedInUint8Array,SessionKey2Uint8Array,{name: 'AES-CBC',iv: SessionIv2Uint8Array}).then( async (EncryptedIsLoggedInUint8Array) => {
                                                    console.log("here5");
                                                    let EncryptedIsLoggedInBase64 = Buffer.from(EncryptedIsLoggedInUint8Array).toString('base64');

                                                    let EncryptedIsLoggedInBase64Encoded = new TextEncoder().encode(EncryptedIsLoggedInBase64);
                                                    var EncryptedIsLoggedIn = Buffer.from(EncryptedIsLoggedInBase64Encoded).toString('utf8')
                                                    await UsersAllCollections.findOneAndUpdate({"UserLoginToken": UserLoginToken},{ $set: {"Sessions": [EncryptedUserLoginToken, EncryptedIsLoggedIn]}}, function(err, res) {
                                                        if (err){
                                                            console.log(err);
                                                            callback(err);
                                                            return
                                                        }
                                                        console.log(username,user.password,UserLoginToken,EncryptedUserLoginToken, EncryptedIsLoggedIn);
                                                        
                                                        console.log("succesfull");
                                                        callback({ Status: "Succefull",SessionKey1,SessionIv1, SessionKey2, SessionIv2});
                                                        socket.emit("Status", "AlreadyLoggedIn")
                                                        Status = "AlreadyLoggedIn";
                                                        return 
                                                    })
                                                })

                                            })

                                            console.log(UserLoginToken);
                                    }
                                    else{
                                        socket.emit("LoginStatus","InvalidPassword")
                                    }
                                }
                            });   
                        }); 
                    });
                }
            });
            socket.on("Register",async function(username,Userpassword, callback) {
                console.log("here");
                if (Status == "NotLoggedIn" && socket.handshake.query.LT == "NotCreated"){ // can also be (socket.handshake.session.UserToken == db.db("users").collection("users").findOne(socket.handshake.auth.username).UserToken == UserLoginToken && socket.handshake.session.IsUserLoggedIn) 
                    console.log("register");
                    var UsersAllCollections = db.db("users").collection("users");
                    await bcrypt.genSalt(SALT_WORK_FACTOR, function(err, salt) {
                        if (err){
                            callback(err);
                        } 
                        console.log("salt");
                        bcrypt.hash(Userpassword, salt,async function(err, hash) {
                            if (err){
                                console.log('er8')
                                callback(err);
                            } 
                            password = hash;
                            
                            try{
                                await UsersAllCollections.findOne({username: username}, async function(err, user){    
                                    try {
                                        if (typeof(user) == "undefined" || user === null){
                                            let date_ob = new Date();
                                            var UserLoginToken = MD5((username) + SHA512(MD5(Userpassword) + MD5(username + Userpassword)));
                                            console.log(UserLoginToken,"UserLoginToken");
                                            var SessionKey1 = GRandom(32)
                                            var SessionIv1 = GRandom(16)

                                            const UserLoginTokenUint8Array = new TextEncoder().encode(UserLoginToken); // arbitrary length of message in Uint8Array
                                            const SessionKey1Uint8Array = new TextEncoder().encode(SessionKey1); // 16 bytes or 32 bytes key in Uint8Array
                                            const SessionIv1Uint8Array = new TextEncoder().encode(SessionIv1); // 16 bytes IV in Uint8Array for AES-CBC mode

                                            var SessionKey2 = GRandom(32)
                                            var SessionIv2 = GRandom(16)
                                            console.log("here2");
                                            const IsLoggedInUint8Array = new TextEncoder().encode("true"); // arbitrary length of message in Uint8Array
                                            const SessionKey2Uint8Array = new TextEncoder().encode(SessionKey2); // 16 bytes or 32 bytes key in Uint8Array
                                            const SessionIv2Uint8Array = new TextEncoder().encode(SessionIv2); // 16 bytes IV in Uint8Array for AES-CBC mode
                                            console.log("here3");
                                            AesA.encrypt(UserLoginTokenUint8Array,SessionKey1Uint8Array,{name: 'AES-CBC',iv: SessionIv1Uint8Array}).then((EncryptedUserLoginTokenUint8Array) => {
                                                let Base64ULT = Buffer.from(EncryptedUserLoginTokenUint8Array).toString('base64');
                                                console.log("here4");

                                                let EncryptedUserLoginTokenBase64Encoded = new TextEncoder().encode(Base64ULT);
                                                var EncryptedUserLoginToken = Buffer.from(EncryptedUserLoginTokenBase64Encoded).toString('utf8')

                                                AesA.encrypt(IsLoggedInUint8Array,SessionKey2Uint8Array,{name: 'AES-CBC',iv: SessionIv2Uint8Array}).then( async (EncryptedIsLoggedInUint8Array) => {
                                                    console.log("here5");
                                                    let EncryptedIsLoggedInBase64 = Buffer.from(EncryptedIsLoggedInUint8Array).toString('base64');

                                                    let EncryptedIsLoggedInBase64Encoded = new TextEncoder().encode(EncryptedIsLoggedInBase64);
                                                    var EncryptedIsLoggedIn = Buffer.from(EncryptedIsLoggedInBase64Encoded).toString('utf8')

                                                    await UsersAllCollections.insertOne({"username":username,"password":password,"UserLoginToken":UserLoginToken, "Sessions": [EncryptedUserLoginToken, EncryptedIsLoggedIn]} , function (err, result) {                                
                                                        if (err){
                                                            console.log(err);
                                                            callback(err);
                                                            return
                                                        }

                                                        console.log(username,password,UserLoginToken,EncryptedUserLoginToken, EncryptedIsLoggedIn);
                                                        console.log("succesfull");
                                                        callback({ Status: "Succefull",SessionKey1,SessionIv1, SessionKey2, SessionIv2});
                                                        socket.emit("Status", "AlreadyLoggedIn")
                                                        Status = "AlreadyLoggedIn";
                                                        return 
                                                            
                                                        }) 
                                                })

                                            })

                                            console.log(UserLoginToken);
                                            
                                        }
                                        else{
                                            console.log('er3')
                                            callback(err);
                                        }
                                    } catch (error) {
                                        console.log('er2', error, err)
                                        callback(err);
                                    }
                                });
                            }
                            catch(error){
                                console.log('er1');
                                callback(err);
                            }
                        });
                    });
                }
            });

            socket.on("Logout", async function(callback){
                Status = "NotLoggedIn"
                socket.handshake.query.LT = "NotCreated"
                console.log(socket.handshake.query.LT);
                callback({Status: "Succefull"})
            })
        });
    }
    
});




http.listen(process.env.PORT,
    "0.0.0.0",
    () => {
    console.log("Server is running on port 80");
});

