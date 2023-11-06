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

        let data = []

        for(let i = 0; i < movies.length; i++){
            if(movies[i].title.toLowerCase().includes(title) === true){
                data.push(movies[i])
            }
        }
        
        return Response.json({data})
        
    }
    else if(params.get("id") !== null){
        const id = parseInt(params.get("id"))
        const movies = await db
            .collection("movies")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();

        let data = []

        for(let i = 0; i < movies.length; i++){
            if(movies[i].id === id){
                data.push(movies[i])
            }
        }

        return Response.json({data})
    }
    else{
        const movies = await db
            .collection("movies")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();
        
            return Response.json({result: movies})
    }
}