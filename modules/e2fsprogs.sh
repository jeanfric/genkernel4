require @pkg_e2fsprogs-${E2FSPROGS_VER}:null:e2fsprogs_compile

e2fsprogs::()
{
	export E2FSPROGS_STAGING="${TEMP}/e2fsprogs-staging"    
	[ -e ${E2FSPROGS_STAGING} ] && rm -rf ${E2FSPROGS_STAGING}
	mkdir -p ${E2FSPROGS_STAGING}
	cd ${E2FSPROGS_STAGING}
    
	genkernel_extract_package "e2fsprogs-${E2FSPROGS_VER}"

	# generate CPIO
	[ -e ${TEMP}/e2fsprogs-cpiogen ] && rm -r ${TEMP}/e2fsprogs-cpiogen
	rm -rf ${TEMP}/e2fsprogs-cpiogen
	mkdir -p ${TEMP}/e2fsprogs-cpiogen/sbin
	cp "${TEMP}/e2fsprogs-staging/sbin/blkid" "${TEMP}/e2fsprogs-cpiogen/sbin/blkid"
	cp "${TEMP}/e2fsprogs-staging/sbin/mke2fs" "${TEMP}/e2fsprogs-cpiogen/sbin/mke2fs"

	cd ${TEMP}/e2fsprogs-cpiogen
	genkernel_generate_cpio_files "e2fsprogs-${E2FSPROGS_VER}" sbin sbin/*
	initramfs_register_cpio "e2fsprogs-${E2FSPROGS_VER}"
    
	# Export e2fsprogs for dependents
	export E2FSPROGS="${TEMP}/e2fsprogs-staging"
}
