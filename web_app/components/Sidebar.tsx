"use client";

import { usePathname } from "next/navigation";
import { useMemo } from "react";
import { HiHome } from "react-icons/hi";
import { BiSearch } from "react-icons/bi";
import Box from "./Box";
import SidebarItem from "./SidebarItem";
import Library from "./Library"; //TODO: remove Library when streaming works
import { Song } from "@/types";
import usePlayer from "@/hooks/usePlayer";
import { twMerge } from "tailwind-merge";
import Playlist from "./Playlist";

interface SidebarProps {
  children: React.ReactNode;
  songs : Song[]
}

const SideBar: React.FC<SidebarProps> = ({
  children,
  songs
}) => {
  const pathname = usePathname();
  const player = usePlayer();
  const routes = useMemo(
    () => [
      {
        icon: HiHome,
        label: "Home",
        active: pathname !== "/search",
        href: "/",
      },
      {
        icon: BiSearch,
        label: "Search",
        active: pathname === "/search",
        href: "/search",
      },
    ],
    [pathname],
  );

  return (
    <div className={
      twMerge(`flex h-full`, player.activeId && "h-[calc(100%-80px)]")
    }>
      <div
        className="
                    hidden
                    md:flex
                    flex-col
                    gap-y-2
                    bg-background0
                    h-full
                    w-[300px]
                    p-2
                "
      >
        <Box className="py-4">
          <div
            className="
                            flex
                            flex-col
                            gap-y-4
                            px-5
                        "
          >
            {routes.map((item) => (
              <SidebarItem key={item.label} {...item} />
            ))}
          </div>
        </Box>
        <Box>
          <Library songs={[]}/>
        </Box>
        <Box className="overflow-y-auto h-full">
          <Playlist songs={songs}/>
        </Box>
      </div>
      <main className="h-full flex-1 overflow-y-auto py-2">
        {children}
      </main>
    </div>
  );
};

export default SideBar;
