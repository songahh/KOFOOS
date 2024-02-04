package com.kofoos.api.image.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface ImageService {

    void uploadImg(MultipartFile multipartFile) throws IOException;
}
