package com.zfs.ssm.test;

import com.zfs.ssm.dao.DeptMapper;
import com.zfs.ssm.dao.EmpMapper;
import com.zfs.ssm.pojo.Dept;
import com.zfs.ssm.pojo.Emp;
import com.zfs.ssm.service.EmpService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author 张福生
 * @version 1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class DaoTest {
    @Autowired
    DeptMapper deptMapper;
    @Autowired
    EmpMapper empMapper;
    @Autowired
    SqlSession sqlSession;
    @Autowired
    EmpService empService;
    @Test
    public void testCRUD(){
        List<Emp> emps = empService.getAll();
        emps.forEach(emp -> System.out.println(emp));
    }
}
