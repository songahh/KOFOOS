package com.kofoos.api.wishlist;

import com.kofoos.api.wishlist.repo.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class WishlistServiceImpl implements WishlistService {
    private WishlistRepository wishlistRepository;
    private UserRepository userRepository;


    public WishlistServiceImpl(WishlistRepository wishlistRepository, UserRepository userRepository) {

        this.wishlistRepository = wishlistRepository;
        this.userRepository = userRepository;
    }

    @Override
    public void like(int productId, String deviceId) {
        userRepository.findUserIdByDeviceId(deviceId);
    }

    @Override
    public void moveItem() {

    }

    @Override
    public void moveItems() {

    }



}
