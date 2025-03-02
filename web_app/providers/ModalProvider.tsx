"use client";

import AuthModal from "@/components/AuthModal";
import AddPlaylist from "@/components/AddPlaylist";
import UploadModal from "@/components/UploadModal";
import { useEffect, useState } from "react";

const ModalProvider = () => {
  const [isMounted, setIsMounted] = useState(false);

  useEffect(() => {
    setIsMounted(true);
  }, []);

  if (!isMounted) {
    return null;
  }

  return (
    <>
      <AuthModal />
      <UploadModal />
      <AddPlaylist />
    </>
  );
};

export default ModalProvider;
