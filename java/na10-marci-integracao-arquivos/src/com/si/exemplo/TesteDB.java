/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.si.exemplo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author helio
 */
public class TesteDB {
    
    private static String dbURL = "jdbc:derby://localhost:1527/pedidos;user=aluno;password=aluno";
    
    public static void main(String[] args) {
        testeInsertSimples();
        testeInsertPreparedStatement();
    }
    
    private static void testeInsertSimples() {
        Connection con = null;
        Statement stmt = null;
        try {
            //1. Abre a conexão com o BD:
            con = createConnection();
            
            //2. Operacao de insert simples:
            stmt = con.createStatement();
            int res = stmt.executeUpdate(
                    "insert into cliente(nome,cpf,endereco) values('Helena','03.444.888-10','Esparta')");
            System.out.println(res+" cliente inserido na tabela cliente.");
            
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            // Liberacao dos recursos:
            if (stmt!=null) {
                try {
                    stmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            if (con!=null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
    
    private static void testeInsertPreparedStatement() {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            //1. Abre a conexão com o BD:
            con = createConnection();
            
            //2. Operacoes de insert com PreparedStatement:
            pstmt = con.prepareStatement(
                    "insert into cliente(nome,cpf,endereco) values(?,?,?)");
            pstmt.setString(1, "Paris");
            pstmt.setString(2, "03.333.434-55");
            pstmt.setString(3, "Troia");
            pstmt.addBatch();
            
            pstmt.setString(1, "Heitor");
            pstmt.setString(2, "04.333.434-55");
            pstmt.setString(3, "Troia");
            pstmt.addBatch();
            
            pstmt.executeBatch();
            System.out.println("Clientes inserido na tabela cliente.");
            
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            // Liberacao dos recursos:
            if (pstmt!=null) {
                try {
                    pstmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            if (con!=null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
    
    private static Connection createConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
        return DriverManager.getConnection(dbURL);
    }
    
}
