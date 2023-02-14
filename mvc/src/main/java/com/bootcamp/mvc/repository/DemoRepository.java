package com.bootcamp.mvc.repository;

import org.springframework.stereotype.Repository;

/**
 * @author Nguyen Thanh Phuong
 */
@Repository
public class DemoRepository {
    public String info() {
        return "Hello world!";
    }
}
