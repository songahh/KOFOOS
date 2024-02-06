package com.kofoos.api.product.repository;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    @Query("select distinct p from Product p join fetch p.image join fetch p.productMaterials where p.barcode = :barcode")
    Optional<Product> findProductByBarcode(String barcode);


    @Query("select distinct p from Product p join fetch p.image join fetch p.productMaterials where p.itemNo = :itemNo")
    Optional<Product> findProductByItemNo(String itemNo);

    @Modifying
    @Query("update Product p set p.hit = p.hit + 1 where p.id = :id")
    void UpHit(int id);


    @Modifying
    @Query("update Product p set p.like = p.like + 1 where p.id = :id")
    void UpLike(int id);


    @Modifying
    @Query("update Product p set p.like = p.like - 1 where p.id = :id")
    void DownLike(int id);

    @Query(value="select * from product where category_id = :category_id order by RAND(:seed) limit 10", nativeQuery = true)
    List<Product> findProductsOrderByRandom(int category_id, int seed);

    @Query("select p from Product p join fetch p.productMaterials join fetch p.image join p.category c on c.cat1 = :cat1 and c.cat2 = :cat2 and c.cat3 = :cat3")
    List<Product> findProductsByCategory(String cat1, String cat2,String cat3);

    @Query("select p from Product p join fetch p.productMaterials join fetch p.image join p.category on p.category.id = :id ORDER BY p.like")
    List<Product> findProductsOrderByLike(int id);
    @Query("select p from Product p join fetch  p.productMaterials join fetch p.image join p.category on p.category.id = :id ORDER BY p.hit")
    List<Product> findProductsOrderByHit(int id);

    @Modifying
    @Query(value = "update product set description = :description, tag_string = :tagString where item_no = :itemNo",nativeQuery = true)
    void updateGptTag(String itemNo, String tagString, String description);

}
