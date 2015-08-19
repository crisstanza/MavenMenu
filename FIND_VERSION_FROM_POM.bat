set VERSION=
for /f "tokens=*" %%a in (pom.xml) do (
	for /f "tokens=1 delims=>,<" %%b IN ("%%a") do (
		if [%%b]==[version] (
			for /f "tokens=2 delims=>,<" %%c IN ("%%a") do (
				set VERSION=%%c
				goto VERSION_FOUND
			)
		)
	)
)
