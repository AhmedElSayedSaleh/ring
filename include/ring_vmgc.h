/* Copyright (c) 2013-2016 Mahmoud Fayed <msfclipper@yahoo.com> */
#ifndef ring_gc_h
#define ring_gc_h
/* Functions */

void ring_vm_gc_checkreferences ( VM *pVM ) ;

void ring_vm_gc_checknewreference ( void *pPointer,int nType ) ;

void ring_vm_gc_checkupdatereference ( List *pList ) ;

void ring_vm_gc_deleteitem ( Item *pItem ) ;

void ring_vm_gc_killreference ( VM *pVM ) ;

void ring_vm_gc_deletetemplists ( VM *pVM ) ;

void ring_vm_gc_newitemreference ( Item *pItem ) ;
/* Memory Functions (General) */

void * ring_malloc ( size_t size ) ;

void ring_free ( void *ptr ) ;

void * ring_calloc ( size_t nitems, size_t size ) ;

void * ring_realloc ( void *ptr, size_t size ) ;
/* Memory Functions (VM Aware) */

void * ring_vm_malloc ( VM *pVM,size_t size ) ;

void ring_vm_free ( VM *pVM,void *ptr ) ;

void * ring_vm_calloc ( VM *pVM,size_t nitems, size_t size ) ;

void * ring_vm_realloc ( VM *pVM,void *ptr, size_t size ) ;
/* Macro */
#define ring_vm_gc_cleardata(pItem) (pItem->gc.nReferenceCount = 0)
#define GCLog 0
#endif
