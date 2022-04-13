package com.zfs.ssm.service.Impl;

import com.zfs.ssm.dao.EmpMapper;
import com.zfs.ssm.pojo.Emp;
import com.zfs.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 张福生
 * @version 1.0
 */
@Service
public class EmpServiceImpl implements EmpService {
    @Autowired
    EmpMapper empMapper;
    @Override
    public List<Emp> getAll() {
        List<Emp> emps = empMapper.selectByExampleWithDept(null);
        return emps;
    }
}
