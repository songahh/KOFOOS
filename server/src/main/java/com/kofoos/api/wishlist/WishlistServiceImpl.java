package com.kofoos.api.wishlist;

import com.kofoos.api.repository.WishlistRepository;
import com.kofoos.api.wishlist.dto.FolderDto;
import com.kofoos.api.wishlist.dto.ProductDto;
import com.kofoos.api.entity.*;
import com.kofoos.api.repository.FolderRepository;
import com.kofoos.api.repository.ProductRepository;
import com.kofoos.api.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

        User currentUser = userRepository.findUserIdByDeviceId(deviceId);
        System.out.println("==============" + currentUser.getId());

        WishlistFolder folder = folderRepository.findFolderByUserIdAndName(currentUser.getId(), DEFAULT);

        if (folder == null) {
            WishlistFolder newfolder = WishlistFolder.builder()
                    .name(DEFAULT)
                    .user(currentUser)
                    .build();

            folder = folderRepository.save(newfolder);

        }

        Optional<Product> productById = productRepository.findById(id);
        Product currentProduct = productById.orElseThrow(() -> new IllegalArgumentException("Product not found"));


        WishlistItem wishlistItem = WishlistItem.builder()
                .product(currentProduct)
                .wishlistFolder(folder)
                .image(currentProduct.getImage())
                .bought(0)
                .build();

        wishlistRepository.save(wishlistItem);

    }



    @Transactional
    @Override
    public void moveItems(List<Integer> itemIds, int targetFolderId) {
        for (int itemId : itemIds) {
            wishlistRepository.updateFolderId(itemId, targetFolderId);
        }
    }

    @Override
    public void cancel(int id, String deviceId) {
        User currentUser = userRepository.findUserIdByDeviceId(deviceId);

        String folderName = DEFAULT;

        WishlistFolder folder = folderRepository.findFolderByUserIdAndName(currentUser.getId(), folderName);

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
    public void create(String folderName, String deviceId) {

        User currentUser = userRepository.findUserIdByDeviceId(deviceId);

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
    public List<FolderDto> findFolderList(String deviceId) {

        User user = userRepository.findUserIdByDeviceId(deviceId);
        List<FolderDto> folders = folderRepository.findFolderByUserId(user.getId());

        for(FolderDto folder : folders){
            folder.setItems(wishlistRepository.findItemsWithImagesByUserId(folder.getFolderId()));

        }


        return folders;
    }


    @Override
    public List<ProductDto> findFolder(int folderId) {
        return wishlistRepository.findProductsByFolderId(folderId);
    }

    @Transactional
    @Override

    public void check(List<Integer> itemIds, int bought) {
        for(int wishlistItemId: itemIds){

            int result = wishlistRepository.updateBought( wishlistItemId, bought);

            System.out.println("업데이트 결과: "+result);
        }

    }


}
