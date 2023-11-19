import client from "@/lib/database"

export async function GET(Request){
    const paramsId = Request.url
    const ID = paramsId.replace("http://localhost:3000/api/movies/","")
    const id = parseInt(ID)
    const db = await client.db("gubukcinema")
    
    try{
        const result = await db
            .collection("movies")
            .findOne({ id : id })

        return Response.json(
            result,
            {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                },
            }
        )
    } catch(e){
        console.error(e)
    }
}