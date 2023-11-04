import Link from 'next/link'

export default function Home() {
  return (
    <div>
      <div className='flex flex-col p-4 items-center justify-center'>
        <div className='flex p-2'>
          <h3 className='font-bold text-2xl'>API GUBUK CINEMA</h3>
        </div>
        <div className='flex gap-4 text-white'>
          <div className='bg-gray-600 rounded-xl'>
            <Link href="/api/account" className='p-4 text-lg'>Account</Link>
          </div>
          <div className='bg-gray-600 rounded-xl'>
            <Link href="/api/movies" className='p-4 text-lg'>Movies</Link>
          </div>
        </div>
      </div>
    </div>
  )
}
