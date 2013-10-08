/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.si.entidade;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Aluno
 */
@Entity
@Table(name = "PEDIDOITEM")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Pedidoitem.findAll", query = "SELECT p FROM Pedidoitem p"),
    @NamedQuery(name = "Pedidoitem.findByIdPedidoItem", query = "SELECT p FROM Pedidoitem p WHERE p.idPedidoItem = :idPedidoItem"),
    @NamedQuery(name = "Pedidoitem.findByQuantidade", query = "SELECT p FROM Pedidoitem p WHERE p.quantidade = :quantidade")})
public class Pedidoitem implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_PEDIDO_ITEM")
    private Integer idPedidoItem;
    @Column(name = "QUANTIDADE")
    private Integer quantidade;
    @JoinColumn(name = "ID_PRODUTO", referencedColumnName = "ID_PRODUTO")
    @ManyToOne(optional = false)
    private Produto idProduto;
    @JoinColumn(name = "ID_PEDIDO", referencedColumnName = "ID_PEDIDO")
    @ManyToOne(optional = false)
    private Pedido idPedido;

    public Pedidoitem() {
    }

    public Pedidoitem(Integer idPedidoItem) {
        this.idPedidoItem = idPedidoItem;
    }

    public Integer getIdPedidoItem() {
        return idPedidoItem;
    }

    public void setIdPedidoItem(Integer idPedidoItem) {
        this.idPedidoItem = idPedidoItem;
    }

    public Integer getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(Integer quantidade) {
        this.quantidade = quantidade;
    }

    public Produto getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(Produto idProduto) {
        this.idProduto = idProduto;
    }

    public Pedido getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(Pedido idPedido) {
        this.idPedido = idPedido;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPedidoItem != null ? idPedidoItem.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Pedidoitem)) {
            return false;
        }
        Pedidoitem other = (Pedidoitem) object;
        if ((this.idPedidoItem == null && other.idPedidoItem != null) || (this.idPedidoItem != null && !this.idPedidoItem.equals(other.idPedidoItem))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.si.entidade.Pedidoitem[ idPedidoItem=" + idPedidoItem + ", idPedido=" + idPedido + ", idProduto=" + idProduto + ", quantidade=" + quantidade +  " ]";
        
    }
    
}
