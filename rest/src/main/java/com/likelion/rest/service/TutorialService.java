package com.likelion.rest.service;

import com.likelion.rest.entity.Tutorial;

import java.util.List;

/**
 * @author Nguyen Thanh Phuong
 */
public interface TutorialService {

    List<Tutorial> findAll();

    List<Tutorial> findByTitle(String title);

    Tutorial findById(Long id);

    void deleteById(Long id);

    void deleteAll();

    List<Tutorial> findByPublished(boolean b);

    Tutorial save(Tutorial tutorial);

}
