const express = require('express');
const router = express.Router();
const seedControllers = require('../controllers/seedControllers');
const userControllers = require('../controllers/userControllers');
const errorController = require('../controllers/errorController');
const jwt = require('../modules/jwttoken');

// Router API
router.route('/').get(jwt.authenticate);
router.route('/token').get(jwt.expiration,userControllers.checkToken);
router.route('/search/:search/:offset').get(seedControllers.searchVar);
router.route('/paginate/seed/:offset').get(seedControllers.paginateSeed);
router.route('/paginate/category/:idcategory/:offset').get(seedControllers.paginateCategory);
router.route('/seed/:idseed').get(seedControllers.getOneSeed);
router.route('/user/seedlist/:iduser').get(seedControllers.allSeedOneuser);//user seed
router.route('/signup').post(userControllers.signUp);//new user
router.route('/signin').post(userControllers.signIn);//connect user
router.route('/category').get(seedControllers.getAllCat);//all category
router.route('/create/seed').post(jwt.authenticate,seedControllers.createdSeed);//create seed
router.route('/update/seed/:idseed').patch(jwt.authenticate,seedControllers.updateSeed);// update seed
router.route('/delete/seed/:idseed').delete(jwt.authenticate,seedControllers.deleteSeed);// delete seed
router.route('/update/user/:iduser').patch(jwt.authenticate,userControllers.updateUser);// update User
router.route('/delete/user/:iduser').delete(jwt.authenticate,userControllers.deleteUser);//delete User
router.route('/uservalidate/:email/:key').patch(userControllers.validateUser);//validate user
router.route('/reset/:email').patch(userControllers.resetMdp)//reset password user
router.use(errorController.api404);
module.exports = router;