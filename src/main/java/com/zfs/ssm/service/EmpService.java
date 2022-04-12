package com.zfs.ssm.service;

import com.zfs.ssm.pojo.Emp;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 张福生
 * @version 1.0
 */
public interface EmpService {
    public List<Emp> getAll();
}
