import client from "@/lib/database"

export async function GET(Request){
    const params = Request.nextUrl.searchParams;
    
    const db = await client.db("gubukcinema")
    
    if(params.get("title") !== null){
        const rawtitle = params.get("title")
        const title = rawtitle.replaceAll("_"," ").replaceAll("`",":")

        const movies = await db
            .collection("movies")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();

        let result = []

        for(let i = 0; i < movies.length; i++){
            if(movies[i].title.toLowerCase().includes(title) === true){
                result.push(movies[i])
            }
        }
        
        return Response.json( result,
        {
            status: 200,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type, Authorization',
            },
        }
    )
        
    }
    else if(params.get("id") !== null){
        const id = parseInt(params.get("id"))
        const movies = await db
            .collection("movies")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();

        let result = []

        for(let i = 0; i < movies.length; i++){
            if(movies[i].id === id){
                result.push(movies[i])
            }
        }

        return Response.json( result,
            {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                },
            }
        )
    }
    else{
        const result = await db
            .collection("movies")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();

            return Response.json( result,
                {
                    status: 200,
                    headers: {
                        'Access-Control-Allow-Origin': '*',
                        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                    },
                }
            )
    }
}