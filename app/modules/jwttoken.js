
const jsonwebtoken = require('jsonwebtoken');
module.exports={
    create(content){
        const jwt_option = {
            algorithm: 'HS256',
            expiresIn: '3h'
        }
        const jwt_content = {
            content
        };
        return jsonwebtoken.sign(jwt_content, process.env.SECRETJWT, jwt_option)
        
    },
authenticate(request, response, next) {
    const authHeader = request.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if (token == null) return response.sendStatus(401)
  
    jsonwebtoken.verify(token, process.env.SECRETJWT, (err, user) => {
      console.log(err)
      if (err) return response.sendStatus(401)
       next()
    })
  }
}