package com.kofoos.api.wishlist;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.common.dto.WishlistFolderDto;
import com.kofoos.api.common.dto.WishlistItemDto;
import com.kofoos.api.entity.*;
import com.kofoos.api.wishlist.repo.FolderRepository;
import com.kofoos.api.wishlist.repo.ProductRepository;
import com.kofoos.api.wishlist.repo.UserRepository;
import io.lettuce.core.ScriptOutputType;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
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
        System.out.println("==============" + currentUser.getId());
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

            System.out.println("folderId: " + folder.getId());
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

        System.out.println("dd: " + wishlistItem.getId());
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

    @Override
    public void check(int itemId, Integer bought) {
        // wishlist_item 테이블을 itemId로 조회해서 bought값으로 변경
        Optional<WishlistItem> wishlistItemOptional = wishlistRepository.findById(itemId);


        if (wishlistItemOptional.isPresent()) {
            WishlistItem item = wishlistItemOptional.get();


        }
    }

    @Override
    public void create(String folderName, String deviceId) {

        User currentUser = userRepository.findUserIdByDeviceId(deviceId).get();

        WishlistFolder newFolder = WishlistFolder.builder()
                .name(folderName)
                .user(currentUser)
                .build();

        folderRepository.save(newFolder);
    }

    @Override
    public void delete(Integer folderId, String deviceId) {


        folderRepository.deleteById((folderId));

    }

    @Override
    public List<WishlistFolderDto> findFolderList(String deviceId) {
        User user = userRepository.findUserIdByDeviceId(deviceId).get();

        //user
        List<WishlistFolder> folderList = folderRepository.findFolderByUserId(user.getId());
         List<WishlistFolderDto> folderDtos = new ArrayList<>();

        for(WishlistFolder folder : folderList){
            WishlistFolderDto folderDto = WishlistFolderDto.of(folder);
            folderDtos.add(folderDto);
        }

        return folderDtos;
    }

    @Override
    public List<ProductDto> findFolder(int folderId) {
        List<Product> productIds = folderRepository.findProductsByFolderId(folderId);
        List<ProductDto> products = new ArrayList<>();

        for(Product id: productIds){
            ProductDto productDto = ProductDto.of(id);
            products.add(productDto);
        }


        return products;
    }


}
