package com.kofoos.api.wishlist;

import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.User;
import com.kofoos.api.entity.WishlistFolder;
import com.kofoos.api.entity.WishlistItem;
import com.kofoos.api.wishlist.repo.FolderRepository;
import com.kofoos.api.wishlist.repo.ProductRepository;
import com.kofoos.api.wishlist.repo.UserRepository;
import io.lettuce.core.ScriptOutputType;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class WishlistServiceImpl implements WishlistService {
    private WishlistRepository wishlistRepository;
    private FolderRepository folderRepository;
    private UserRepository userRepository;
    private ProductRepository productRepository;
    final String DEFAULT = "default";


    public WishlistServiceImpl(WishlistRepository wishlistRepository, FolderRepository folderRepository, UserRepository userRepository, ProductRepository productRepository) {
        this.wishlistRepository = wishlistRepository;
        this.folderRepository = folderRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
    }

    @Override
    public void like(int id, String deviceId) {

        Optional<User> optionalUser = userRepository.findUserIdByDeviceId(deviceId);
        User currentUser = optionalUser.get();
        System.out.println("=============="+currentUser.getId());
        int userId = optionalUser.map(User::getId).orElse(0);


        Optional<WishlistFolder> folderByUserIdAndName = folderRepository.findFolderByUserIdAndName(userId, DEFAULT);

        WishlistFolder folder;
        if (!folderByUserIdAndName.isPresent()) {
            // 폴더가 없는 경우, 새로운 폴더 생성 및 저장
            WishlistFolder newfolder = WishlistFolder.builder()
                    .name(DEFAULT)
                    .user(currentUser)
                    .build();


            folder = folderRepository.save(newfolder);

            System.out.println("folderId: "+folder.getId());
        } else {
            folder = folderByUserIdAndName.get();
        }

        Optional<Product> productById = productRepository.findById(id);
        Product currentProduct = productById.orElseThrow(() -> new IllegalArgumentException("Product not found"));


        WishlistItem wishlistItem = WishlistItem.builder()
                .product(currentProduct)
                .wishlistFolder(folder)
                .image(currentProduct.getImage())
                .build();

        System.out.println("dd: "+wishlistItem.getId());
        System.out.println(wishlistItem.getBought());
        System.out.println(wishlistItem.getImage());
        System.out.println(wishlistItem.getWishlistFolder().getId());
        WishlistItem wishItem = wishlistRepository.save(wishlistItem);

    }

    @Override
    public void moveItem() {

    }

    @Override
    public void moveItems() {

    }

    @Override
    public void cancel(int id, String deviceId) {
        Optional<User> optionalUser = userRepository.findUserIdByDeviceId(deviceId);
        User currentUser = optionalUser.orElseThrow(() -> new IllegalArgumentException("User not found"));
        int userId = currentUser.getId();

        String folderName = DEFAULT;

        Optional<WishlistFolder> folderByUserIdAndName = folderRepository.findFolderByUserIdAndName(userId, folderName);
        if (!folderByUserIdAndName.isPresent()) {
            System.out.println("폴더없음");
            return;
        }
        WishlistFolder folder = folderByUserIdAndName.get();

        Optional<Product> productById = productRepository.findById(id);
        Product currentProduct = productById.orElseThrow(() -> new IllegalArgumentException("Product not found"));


        // WishlistItem 찾기
        Optional<WishlistItem> wishlistItem = wishlistRepository.findWishlistItemByWishlistFolderIdAndProductId(folder.getId(), currentProduct.getId());

        // 존재하는 경우 삭제
        if (!wishlistItem.isPresent()) {
            System.out.println("sorry!!");
        }
        wishlistRepository.delete(wishlistItem.get());
    }


}
