package com.bootcamp.mvc.service.impl;

import com.bootcamp.mvc.repository.DemoRepository;
import com.bootcamp.mvc.service.IDemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Nguyen Thanh Phuong
 */
@Service
public class DemoServiceImpl implements IDemoService {
    @Autowired
    private DemoRepository demoRepository;

    @Override
    public String getInfo() {
        return demoRepository.info();
    }
}
