import client from "@/lib/database"

export async function POST(Request) {
    const data = await Request.json()
    const db = await client.db("gubukcinema")
    
    if(data.username !== null && data.password !== null){
        const username = data.username;
        const password = data.password;
        
        try{
            const account = await db
                .collection("account")
                .findOne({
                    username: username,
                    password: password
                })
            if(account !== null){
                return Response.json( {
                    message: "Data is Exist!"
                },
                    {
                        status: 200,
                        headers: {
                            'Access-Control-Allow-Origin': '*',
                            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                            'Access-Control-Allow-Headers': 'Content-Type, application/json',
                        },
                    }
                );
            }
            else{
                return Response.json( {
                    message: "Data is Not Exist!"
                },
                    {
                        status: 200,
                        headers: {
                            'Access-Control-Allow-Origin': '*',
                            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                            'Access-Control-Allow-Headers': 'Content-Type, application/json',
                        },
                    }
                );
            }
           
            
        } catch(e) {
            console.error(e)
        }
    }
    else{
        return Response.json({mesage: "Username or Password Can't be Empty"},
            {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, application/json',
                },
            }
        )
    }
}
