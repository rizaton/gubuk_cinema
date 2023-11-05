"use client"

import { ArrowRight, GithubLogo } from '@phosphor-icons/react'
import Link from 'next/link'

export default function Home() {
  return (
    <div>
      <div className='flex flex-col p-4 items-center justify-center'>
        <div className='flex p-2'>
          <h3 className='font-bold text-2xl'>API GUBUK CINEMA</h3>
        </div>
        <div className='flex gap-4 text-white'>
          <div className='bg-gray-600 rounded-md'>
            <Link href="/api/account" className='p-4 text-lg'>Account</Link>
          </div>
          <div className='bg-gray-600 rounded-md'>
            <Link href="/api/movies" className='p-4 text-lg'>Movies</Link>
          </div>
        </div>
        <div className='flex gap-4 text-white  text-center items-centers py-4'>
          <Link href="https://github.com/Fush1ren/gubukcinema" target='_blank' className='py-2 px-4 gap-2 flex flex-row text-center items-centers bg-cyan-900 rounded-lg'>
            <h3 className='text-lg'>Github</h3>
            <div className='flex items-center'>
              <GithubLogo size={20} />
            </div>
          </Link>
        </div>
      </div>
    </div>
  )
}
